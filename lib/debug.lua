local debug_mod = {}

function debug_mod.setup()
  vim.cmd([[command! UVMDebug lua require("nvim-uvm-log-highlight.lib.debug").parse_debug()]])
end

function debug_mod.parse_debug()
  -- 示例：解析日志中 DEBUG 行，并打印相关信息
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  for i, line in ipairs(lines) do
    if line:find("UVM_DEBUG") then
      print("Debug at line " .. i .. ": " .. line)
    end
  end
end

return debug_mod
