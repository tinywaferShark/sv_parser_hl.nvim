local panel = {}

function panel.setup()
  vim.cmd([[command! UVMPanel lua require("nvim-uvm-log-highlight.lib.panel").open_panel()]])
end

function panel.open_panel()
  -- 示例：临时打开一个分割窗口，展示交互式过滤选项
  vim.cmd("vsplit")
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, buf)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
    "交互式过滤器面板",
    "输入过滤条件后，按 Enter 执行过滤",
    "示例：DEBUG, INFO, ERROR 等",
  })
end

return panel
