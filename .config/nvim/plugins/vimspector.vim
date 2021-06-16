let g:python3_host_prog = '/usr/bin/python3'

fun! GotoWindow(id)
    call win_gotoid(a:id)
    MaximizerToggle
endfun
" Debugger remaps
nnoremap <leader>dd <CMD>call vimspector#Launch()<CR>
nnoremap <leader>dc <CMD>call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dt <CMD>call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>dv <CMD>call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dw <CMD>call GotoWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>ds <CMD>call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do <CMD>call GotoWindow(g:vimspector_session_windows.output)<CR>
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
