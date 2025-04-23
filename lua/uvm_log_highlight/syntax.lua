local M = {}

function M.load()
  -- 关键字高亮
  vim.cmd("syntax keyword uvmInfo UVM_INFO")
  vim.cmd("syntax keyword uvmError UVM_ERROR")
  vim.cmd("syntax keyword uvmFatal UVM_FATAL")
  vim.cmd("syntax keyword uvmWarning UVM_WARNING")

  -- 匹配时间格式
  vim.cmd([[syntax match uvmTime "@ \d\+"]])

  -- 匹配十六进制数值（0xDEADBEEF）
  vim.cmd([[syntax match uvmHexNumber "0x[0-9A-Fa-f]\+"]])

  -- 匹配二进制数值（0b01010101 或 0b01010101.）
  vim.cmd([[syntax match uvmBinNumber "0[bB][01]\+\(\.[01]*\)\?"]])

  -- 匹配带前缀的数值
  vim.cmd([[syntax match uvmHexDataValue "'[hH][0-9A-Fa-f]\+\(\.[0-9A-Fa-f]\+\)\?"]])
  vim.cmd([[syntax match uvmDecDataValue "'[dD]\d\+\(\.\d\+\)\?"]])
  vim.cmd([[syntax match uvmBinDataValue "'[bB][01]\+\(\.[01]\+\)\?"]])

  -- 高亮链接
  vim.cmd("highlight default link uvmInfo Keyword")
  vim.cmd("highlight default link uvmError Error")
  vim.cmd("highlight default link uvmFatal Error")
  vim.cmd("highlight default link uvmWarning Error")
  vim.cmd("highlight default link uvmTime Number")
  vim.cmd("highlight default link uvmHexNumber Constant")
  vim.cmd("highlight default link uvmDecNumber Constant")
  vim.cmd("highlight default link uvmBinNumber Constant")
  vim.cmd("highlight default link uvmHexDataValue Constant")
  vim.cmd("highlight default link uvmDecDataValue Constant")
  vim.cmd("highlight default link uvmBinDataValue Constant")

  -- 更加醒目的高亮
  vim.cmd("highlight uvmError ctermfg=Red guifg=#FF0000 cterm=bold gui=bold")
  vim.cmd("highlight uvmFatal ctermfg=Red guifg=#FF0000 cterm=bold gui=bold")
  vim.cmd("highlight uvmWarning ctermfg=Yellow guifg=#FFD700 cterm=bold gui=bold")
end

return M