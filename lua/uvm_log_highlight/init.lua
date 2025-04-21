local M = {}

local config = {
  max_file_mb = 100, -- 默认最大文件大小（MB）
}

-- 加载语法文件
local function load_syntax()
  vim.notify("--- syntax uvm_log_highlight ---", vim.log.levels.INFO)
  vim.notify("--- syntax uvm_log_highlight12123 ---", vim.log.levels.INFO)
  vim.cmd("source /home/shark/Projects/uvm_log_highlight/lua/uvm_log_highlight/syntax/uvm_log.vim")
end

-- 加载各模块（根据需要在开启 uvm_log 文件时调用）
local function init_modules()
  require("uvm_log_highlight.lib.clear").setup()  -- 新增：注册 Uvmlog_clear 命令
  require("uvm_log_highlight.lib.filter").setup()
  require("uvm_log_highlight.lib.jump").setup()
  require("uvm_log_highlight.lib.folding").setup()
  require("uvm_log_highlight.lib.timeline").setup()
  require("uvm_log_highlight.lib.panel").setup()
  require("uvm_log_highlight.lib.multiview").setup()
  require("uvm_log_highlight.lib.refresh").setup()
  require("uvm_log_highlight.lib.debug").setup()
  require("uvm_log_highlight.lib.feedback").setup()
end

function M.setup(user_config)
  config = vim.tbl_deep_extend("force", config, user_config or {})

  -- 文件大小检测
  vim.api.nvim_create_autocmd({ "BufReadPre" }, {
    pattern = "*.log",
    callback = function(args)
      local file = args.file
      local stat = vim.loop.fs_stat(file)
      if stat and stat.size and stat.size > config.max_file_mb * 1024 * 1024 then
        vim.notify(
          string.format("文件过大（%.2f MB），已禁止打开！", stat.size / 1024 / 1024),
          vim.log.levels.ERROR
        )
        vim.cmd("bd!") -- 关闭当前 buffer
      end
    end,
  })

  -- 文件类型设置
  vim.opt.runtimepath:append("~/Projects/uvm_log_highlight/lua/uvm_log_highlight")
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.log",
    callback = function()
      vim.cmd("set filetype=uvm_log")
    end,
  })

  -- 对 uvm_log 文件加载语法与初始化各模块
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "uvm_log",
    callback = function()
      load_syntax()
      init_modules()
    end,
  })
end

return M