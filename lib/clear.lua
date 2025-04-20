local M = {}

-- function M.clear_paths()
--   local bufnr = vim.api.nvim_get_current_buf()
--   local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
--   for i, line in ipairs(lines) do
--     local new_line = line:gsub("(/ic/projects/.-)([^/\\ ]+)", "%2")
--     new_line = new_line:gsub("(/ic/eda_tools/.-)([^/\\ ]+)", "%2")
--     lines[i] = new_line
--   end
--   vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
--   vim.notify("路径已清理", vim.log.levels.INFO)
-- end

-- -- 如果命令未注册过，则注册用户命令
-- if not _G.__uvmlog_clear_cmd_registered then
--   vim.api.nvim_create_user_command("Uvmlog_clear", function()
--     M.clear_paths()
--   end, {})
--   _G.__uvmlog_clear_cmd_registered = true
-- end

-- function M.setup()
--   -- 此模块的 setup 此时可以为空或者进行其它初始化操作
-- end

return M