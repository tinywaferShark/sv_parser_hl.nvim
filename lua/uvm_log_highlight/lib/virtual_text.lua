local M = {}

local default_virtual_text = {
  -- info = {
  --   words = { "UVM_INFO" },
  --   text = "[INFO]",
  --   hl_group = "Comment"
  -- },
  warning = {
    words = { "UVM_WARNING" },
    text = "[WARN]",
    hl_group = "WarningMsg"
  },
  error = {
    words = { "UVM_ERROR" },
    text = "[ERR!]",
    hl_group = "ErrorMsg"
  },
  fatal = {
    words = { "UVM_FATAL" },
    text = "[FATAL]",
    hl_group = "ErrorMsg"
  },
}

local config = {
  virtual_text = default_virtual_text,
  enable_virtual_text = true,
}

M.namespace_id = vim.api.nvim_create_namespace("uvm_log_virtual_text")

local function clear_virtual_text(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not vim.api.nvim_buf_is_valid(bufnr) then return end
  vim.api.nvim_buf_clear_namespace(bufnr, M.namespace_id, 0, -1)
end

function M.apply_virtual_text(bufnr, user_config)
  config = vim.tbl_deep_extend("force", config, user_config or {})
  if not config.enable_virtual_text then return end
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not vim.api.nvim_buf_is_valid(bufnr) then return end
  clear_virtual_text(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  for rule_name, entry in pairs(config.virtual_text) do
    if entry.words and #entry.words > 0 and entry.text and entry.hl_group then
      local virt_text_opts = {
        virt_text = {{ entry.text, entry.hl_group }},
        virt_text_pos = 'eol',
      }
      for i = 0, #lines - 1 do
        local line_content = lines[i + 1]
        for _, word in ipairs(entry.words) do
          if string.find(line_content, word, 1, true) then
            vim.api.nvim_buf_set_extmark(bufnr, M.namespace_id, i, -1, virt_text_opts)
            break
          end
        end
      end
    end
  end
end

function M.clear(bufnr)
  clear_virtual_text(bufnr)
end

return M