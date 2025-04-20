" Highlight UVM log elements
syntax keyword uvmInfo UVM_INFO
syntax keyword uvmError UVM_ERROR

" 匹配时间格式（例如：@ 12345）
syntax match uvmTime "@ \d\+"

" 匹配十六进制数值（例如：0xDEADBEEF）
syntax match uvmHexNumber "0x[0-9A-Fa-f]\+"

" 匹配十进制数值（例如：123456）
syntax match uvmDecNumber "\<\d\+\>"

" 匹配二进制数值（例如：0b01010101）
syntax match uvmBinNumber "0b[01]\+"

" 匹配带前缀的数值（例如：'h7F7F7F, 'd123456, 'b101010）
syntax match uvmDataValue "'[hdbo]\d\+" 

" 设置高亮
highlight default link uvmInfo Keyword
highlight default link uvmError Error
highlight default link uvmTime Number
highlight default link uvmHexNumber Constant
highlight default link uvmDecNumber Constant
highlight default link uvmBinNumber Constant
highlight default link uvmDataValue Constant
