local M = {}

-- 加载语法文件
local function load_syntax()
  vim.notify("--- syntax uvm_log_highlight ---", vim.log.levels.INFO)
  vim.notify("--- syntax uvm_log_highlight12123 ---", vim.log.levels.INFO)
  vim.cmd("source /home/shark/Projects/uvm_log_highlight/lua/uvm_log_highlight/syntax/uvm_log.vim")
end

-- 加载各模块（根据需要在开启 uvm_log 文件时调用）
local function init_modules()
  -- require("uvm_log_highlight.lib.clear").setup()  -- 新增：注册 Uvmlog_clear 命令
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

function M.setup()
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

-- lua/plugins/nvim-uvm-log-highlight/init.lua
-- local M = {}

-- function M.setup()

--   vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--     pattern = "*.log",
--     callback = function()
--       vim.cmd("set filetype=uvm_log")
--     end,
--   })

--   vim.api.nvim_create_autocmd("FileType", {
--     pattern = "uvm_log",
--     callback = function()
--       vim.notify("--- syntax uvm_log_highlight ---", vim.log.levels.INFO)
--       vim.cmd("runtime syntax/uvm_log.vim")
--     end,
--   })
-- end

-- return M