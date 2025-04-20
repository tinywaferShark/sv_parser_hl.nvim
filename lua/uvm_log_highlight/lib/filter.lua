local filter = {}

function filter.setup()
  -- 示例：在当前 buffer 对日志内容执行搜索操作，后续可扩展为交互窗口
  vim.cmd([[command! UVMFilter lua require("nvim-uvm-log-highlight.lib.filter").filter()]])
end

function filter.filter()
  local query = vim.fn.input("Filter logs: ")
  -- 简单示例：高亮包含查询词的行       
  vim.fn.matchadd("Search", query)
  print("Filtering logs with: " .. query)
end

return filter
