local timeline = {}

function timeline.setup()
  vim.cmd([[command! UVMTimeline lua require("nvim-uvm-log-highlight.lib.timeline").show_timeline()]])
end

function timeline.show_timeline()
  -- 示例：解析buffer中所有时间信息，并以列表展示统计
  local bufnr = vim.api.nvim_get_current_buf()
  local logs = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local times = {}
  for _, line in ipairs(logs) do
    local time = line:match("@ (%d+)")
    if time then
      table.insert(times, time)
    end
  end
  print("Timeline timestamps: " .. table.concat(times, ", "))
end

return timeline
