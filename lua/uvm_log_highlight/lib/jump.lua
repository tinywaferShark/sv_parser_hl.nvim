local jump = {}

function jump.setup()
  -- 示例：为日志中可能的文件链接创建快捷键
  vim.api.nvim_buf_set_keymap(0, "n", "gl", ":lua require('nvim-uvm-log-highlight.lib.jump').jump_link()<CR>", { noremap = true, silent = true })
end

function jump.jump_link()
  -- 简单示例：识别当前光标所在行中可能文件路径，并打开该文件
  local line = vim.api.nvim_get_current_line()
  local filepath = line:match("(%S+%.v)%s*$")  -- 假设以 .v 结尾的文件路径
  if filepath then
    vim.cmd("edit " .. filepath)
  else
    print("没有识别到链接")
  end
end

return jump
