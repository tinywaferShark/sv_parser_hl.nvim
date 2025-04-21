local M = {}

-- 默认配置
local config = {
  -- 可以通过 setup 函数覆盖这些前缀
  prefixes = {
    "/ic/projects/",
    "/ic/eda_tools/",
  }
}

local function build_patterns()
  local patterns = {}
  for _, p in ipairs(config.prefixes) do
    table.insert(patterns, string.format("(%s)([^\n ]+)", vim.pesc(p)))
  end
  return patterns
end

function M.clear_paths()
  local patterns = build_patterns()
  print("当前patterns:", vim.inspect(patterns))
  if not patterns or #patterns == 0 then
    vim.notify("UvmlogClear: 没有配置路径前缀", vim.log.levels.WARN)
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  vim.schedule(function()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local modified_lines = {}
    local changed = false

    for i, line in ipairs(lines) do
      print("匹配前:", line)
      local new_line = line
      local count = 0
      for _, pattern in ipairs(patterns) do
        new_line, c = new_line:gsub(pattern, function(prefix, path)
          local filename = path:match("([^/]+)$")
          print("需要替换的字符串:", filename)
          return filename or path
        end)
        count = count + c
      end
      print("匹配后:", new_line, "替换次数:", count)
      modified_lines[i] = new_line
      if count > 0 then
        changed = true
      end
    end

    if changed then
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, modified_lines)
      vim.notify("UvmlogClear: 路径已清理", vim.log.levels.INFO)
    else
      vim.notify("UvmlogClear: 未找到需要清理的路径", vim.log.levels.INFO)
    end
  end)
end

-- 注册用户命令 (如果尚未注册)
if not _G.__uvmlog_clear_cmd_registered then
  -- print(">>> [uvmlog_clear] Registering UvmlogClear command")
  vim.api.nvim_create_user_command(
    "UvmlogClear", -- 命令名称
    function()
      print(">>> [uvmlog_clear] UvmlogClear command triggered")
      M.clear_paths()
    end,
    {
      desc = "清理日志中 /ic/... 长路径为文件名", -- 命令描述 (可选，推荐)
      nargs = 0 -- 命令不需要参数
    }
  )
  _G.__uvmlog_clear_cmd_registered = true
else
  print(">>> [uvmlog_clear] UvmlogClear command already registered")
end

-- Setup 函数，允许用户覆盖默认配置
-- 使用方法: require('uvmlog_clear').setup { prefixes = {"/my/custom/path/"} }
function M.setup(user_config)
  -- 使用 vim.tbl_deep_extend 合并用户配置和默认配置
  -- 'force' 表示用户配置会覆盖默认值
  config = vim.tbl_deep_extend("force", config, user_config or {})
  -- 你可以在这里添加其他初始化逻辑，例如检查配置是否有效
  vim.notify("UvmlogClear: 配置已加载", vim.log.levels.DEBUG) -- 使用 DEBUG 级别，避免打扰用户
end

return M