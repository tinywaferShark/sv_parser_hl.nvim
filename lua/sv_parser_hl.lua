local M = {}
--TODO:use system cmd to run verible-parser
M.getparser = function()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	for i, line in ipairs(lines) do
		print(line)
	end
end

M.debug_print = function()
	print("hello neovim")
end

return M
