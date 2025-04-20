local feedback = {}

function feedback.setup()
  vim.cmd([[command! UVMFeedback lua require("nvim-uvm-log-highlight.lib.feedback").submit_feedback()]])
end

function feedback.submit_feedback()
  -- 示例：借助 vim.fn.input 收集用户反馈，并输出到日志文件或发送到指定接口
  local msg = vim.fn.input("Your feedback: ")
  if msg and msg ~= "" then
    -- 这里只是简单打印，后续可扩展为写入文件或HTTP上报
    print("Feedback submitted: " .. msg)
  else
    print("反馈为空")
  end
end

return feedback
