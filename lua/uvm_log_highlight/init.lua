local M = {}

local config = {
  max_file_mb = 100,
}

local function load_syntax()
  vim.cmd("runtime syntax/uvm_log.vim")
end

local function init_modules()
  require("uvm_log_highlight.lib.clear").setup()
  -- require("uvm_log_highlight.lib.filter").setup()
  -- require("uvm_log_highlight.lib.jump").setup()
  -- require("uvm_log_highlight.lib.folding").setup()
  -- require("uvm_log_highlight.lib.timeline").setup()
  -- require("uvm_log_highlight.lib.panel").setup()
  -- require("uvm_log_highlight.lib.multiview").setup()
  -- require("uvm_log_highlight.lib.refresh").setup()
  -- require("uvm_log_highlight.lib.debug").setup()
  -- require("uvm_log_highlight.lib.feedback").setup()
end

local virtual_text = require("uvm_log_highlight.lib.virtual_text")

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

  -- 添加 runtimepath
  -- vim.opt.runtimepath:append("~/Projects/uvm_log_highlight/lua/uvm_log_highlight")

  -- 文件类型设置
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.log", "test_status.hud" },  -- 支持 .log 和 test_status.hud
    callback = function()
      vim.cmd("set filetype=uvm_log")
    end,
  })

  -- 对 uvm_log 文件加载语法、初始化模块、应用虚拟文本
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "uvm_log",
    callback = function(args)
      load_syntax()
      init_modules()
      virtual_text.apply_virtual_text(args.buf, user_config and user_config.virtual_text)
    end,
  })
end

return M