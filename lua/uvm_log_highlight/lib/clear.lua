-- ~/.config/nvim/lua/uvmlog_clear/init.lua
-- 或者如果你使用包管理器，可能是 ~/.config/nvim/plugged/uvmlog_clear.nvim/lua/uvmlog_clear/init.lua 等

local M = {}

-- print("--- Loading uvm_log_highlight.lib.clear ---")
vim.notify("--- Loading uvm_log_highlight.lib.clear ---", vim.log.levels.INFO)
-- print(">>> [uvmlog_clear] lib/clear.lua loaded")

-- 默认配置
local config = {
  -- 可以通过 setup 函数覆盖这些前缀
  prefixes = {
    "/ic/projects/",
    "/ic/eda_tools/",
  }
}

-- 根据配置动态构建正则表达式模式
-- 模式解释:
-- ((prefix1|prefix2|...).-) : 捕获组 1 - 匹配整个前缀路径部分 (包括最后一个 /)
--   (prefix1|prefix2|...)  : 捕获组 2 - 匹配配置中的任意一个前缀
--   .-                     : 非贪婪匹配前缀和文件名之间的任何字符
-- ([^/\\ ]+)             : 捕获组 3 - 匹配最后一个 / 后面的非斜杠、非反斜杠、非空格的字符序列 (即文件名)
-- 替换为 "%3" 意味着只保留捕获组 3 (文件名)
local function build_pattern()
  if not config.prefixes or #config.prefixes == 0 then
    return nil
  end
  -- 对前缀进行转义，以防包含特殊正则字符 (虽然例子中没有)
  local escaped_prefixes = {}
  for _, p in ipairs(config.prefixes) do
    table.insert(escaped_prefixes, vim.pesc(p)) -- vim.pesc 用于转义 Lua 模式特殊字符
  end
  local prefix_pattern_part = table.concat(escaped_prefixes, "|")
  -- 构建最终的 Lua pattern
  return string.format("((%s).-)([^/\\ ]+)", prefix_pattern_part)
end

-- 清理当前 buffer 中指定前缀的路径
function M.clear_paths()
  local pattern = build_pattern()
  if not pattern then
    vim.notify("UvmlogClear: 没有配置路径前缀", vim.log.levels.WARN)
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()

  -- 使用 vim.schedule 包装 API 调用是一个好习惯
  vim.schedule(function()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local modified_lines = {}
    local changed = false

    for i, line in ipairs(lines) do
      -- 使用 string.gsub 进行替换，它会返回新字符串和替换次数
      local new_line, count = line:gsub(pattern, "%3") -- %3 对应文件名的捕获组
      modified_lines[i] = new_line
      if count > 0 then
        changed = true -- 标记至少有一行被修改了
      end
    end

    -- 只有在实际发生更改时才写回 buffer
    if changed then
      -- 替换整个 buffer 内容
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, modified_lines)
      vim.notify("UvmlogClear: 路径已清理", vim.log.levels.INFO)
    else
      vim.notify("UvmlogClear: 未找到需要清理的路径", vim.log.levels.INFO)
    end
  end)
end

-- 注册用户命令 (如果尚未注册)
if not _G.__uvmlog_clear_cmd_registered then
  print(">>> [uvmlog_clear] Registering UvmlogClear command")
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