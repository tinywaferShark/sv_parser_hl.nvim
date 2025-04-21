-- lib/multiview.lua
local multiview = {}

function multiview.setup()
  -- print("Setting up multiview module")
  vim.cmd([[command! UVMMultiView lua require("uvm_log_highlight.lib.multiview").open_views(vim.fn.expand('%:p'))]])
  vim.cmd([[command! UVMCloseViews lua require("uvm_log_highlight.lib.multiview").close_views()]])
end

function multiview.close_views()
  -- 关闭当前窗口
  vim.cmd("q")
  -- 如果需要关闭所有窗口，可以使用
  -- vim.cmd("qa")
end

-- 读取日志文件并根据类型分类
function multiview.load_logs(file_path)
  local logs = {
    error_logs = {},
    warning_logs = {},
    info_logs = {},
  }

  for line in io.lines(file_path) do
    if line:match("ERROR") then
      table.insert(logs.error_logs, line)
    elseif line:match("WARNING") then
      table.insert(logs.warning_logs, line)
    elseif line:match("INFO") then
      table.insert(logs.info_logs, line)
    end
  end

  return logs
end

-- 创建视图并显示日志
function multiview.open_views(file_path)
  print("Opening multiple views for logs from: " .. file_path)

  -- 加载日志
  local logs = multiview.load_logs(file_path)

  -- 创建一个新的垂直分屏
  vim.cmd("vsplit")

  -- 创建并显示错误日志
  local error_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(error_buf, 0, -1, false, logs.error_logs)
  vim.api.nvim_set_current_buf(error_buf)
  vim.cmd("setlocal buftype=nofile")  -- 设置缓冲区类型为无文件

  -- 切换到下一个窗口并显示警告日志
  vim.cmd("wincmd w")
  local warning_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(warning_buf, 0, -1, false, logs.warning_logs)
  vim.api.nvim_set_current_buf(warning_buf)
  vim.cmd("setlocal buftype=nofile")

  -- 切换到下一个窗口并显示信息日志
  vim.cmd("wincmd w")
  local info_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(info_buf, 0, -1, false, logs.info_logs)
  vim.api.nvim_set_current_buf(info_buf)
  vim.cmd("setlocal buftype=nofile")

  print("Opened multiple views for logs")
end

return multiview
