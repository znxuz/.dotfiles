syn match CompilerError   "error:\|ERROR:"
syn match CompilerWarning "warning:\|WARNING:"
syn match CompilerPath    "\v(\/|\w)+\.(c|cpp|h|hpp):(\d+:)*"
syn match CompilerNumber  "\v<\d+>"

hi link CompilerError   Error
hi link CompilerWarning WarningMsg
hi link CompilerPath    Underlined
hi link CompilerNumber  Number
