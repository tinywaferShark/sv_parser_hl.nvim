" Highlight UVM log elements
syntax keyword uvmInfo UVM_INFO
syntax keyword uvmError UVM_ERROR
syntax keyword uvmFatal UVM_FATAL
syntax keyword uvmWarning UVM_WARNING

" 匹配时间格式（例如：@ 12345）
syntax match uvmTime "@ \d\+"

" 匹配十六进制数值（例如：0xDEADBEEF）
syntax match uvmHexNumber "0x[0-9A-Fa-f]\+"

" 匹配二进制数值（例如：0b01010101 或 0b01010101.）
syntax match uvmBinNumber "0[bB][01]\+\(\.[01]*\)\?"

" 匹配带前缀的数值：
" 'h 后面都是16进制数据（例如：'h7F7F7F）
syntax match uvmHexDataValue "'[hH][0-9A-Fa-f]\+\(\.[0-9A-Fa-f]\+\)\?"

" 'd 后面都是十进制数据（例如：'d123456）
syntax match uvmDecDataValue "'[dD]\d\+\(\.\d\+\)\?"

" 'b 后面都是2进制数据（例如：'b101010）
syntax match uvmBinDataValue "'[bB][01]\+\(\.[01]\+\)\?"

" 删除或注释掉原来的通用规则
" syntax match uvmDataValue "'[hdboHDOB][0-9A-Fa-f]\+\(\.[0-9A-Fa-f]\+\)\?"

" 设置高亮
highlight default link uvmInfo Keyword
highlight default link uvmError Error
highlight default link uvmFatal Error
highlight default link uvmWarning Error
highlight default link uvmTime Number
highlight default link uvmHexNumber Constant
highlight default link uvmDecNumber Constant
highlight default link uvmBinNumber Constant
highlight default link uvmHexDataValue Constant
highlight default link uvmDecDataValue Constant
highlight default link uvmBinDataValue Constant

highlight uvmError ctermfg=Red guifg=#FF0000 cterm=bold gui=bold
highlight uvmFatal ctermfg=Red guifg=#FF0000 cterm=bold gui=bold
highlight uvmWarning ctermfg=Yellow guifg=#FFD700 cterm=bold gui=bold
