let g:python3_host_prog = '/usr/bin/python3'

" Debugger remaps
nnoremap <leader>dd <CMD>call vimspector#Launch()<CR>
nnoremap <leader>de <CMD>call vimspector#Reset()<CR>

nnoremap <leader>dtcb :call vimspector#CleanLineBreakpoint()<CR>
nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>d^ <Plug>VimspectorRestart
nnoremap <leader>d<space> :call vimspector#Continue()<CR>

nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint
	" <Plug>VimspectorStop
	" <Plug>VimspectorPause
	" <Plug>VimspectorAddFunctionBreakpoint
