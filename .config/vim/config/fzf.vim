fu! s:send_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    cope
    cc
endf

let g:fzf_action = {
	    \ 'ctrl-q': function('s:send_quickfix_list'),
	    \ 'ctrl-s': 'split',
	    \ 'ctrl-v': 'vsplit'
	    \ }
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.6, 'border' : 'sharp' } }
let g:fzf_colors =
	    \ {
	    \ 'fg':      ['fg', 'Normal'],
	    \ 'bg':      ['bg', 'Normal'],
	    \ 'hl':      ['fg', 'Comment'],
	    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
	    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn', 'Normal'],
	    \ 'gutter':  ['bg', 'Normal'],
	    \ 'hl+':     ['fg', 'Statement'],
	    \ 'info':    ['fg', 'PreProc'],
	    \ 'border':  ['fg', 'LineNr'],
	    \ 'prompt':  ['fg', 'Conditional'],
	    \ 'pointer': ['fg', 'Exception'],
	    \ 'marker':  ['fg', 'Keyword'],
	    \ 'spinner': ['fg', 'Label'],
	    \ 'header':  ['fg', 'Comment']
	    \ }
let g:fzf_preview_window = ['right:50%:hidden', 'ctrl-/']
let $FZF_DEFAULT_COMMAND=$FZF_DEFAULT_COMMAND .. ' -tf'
let $FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS .. ' ' ..
	    \ '--bind ctrl-y:preview-up,ctrl-e:preview-down,' ..
	    \ 'ctrl-b:preview-page-up,ctrl-f:preview-page-down,' ..
	    \ 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down'

nn <leader>p <cmd>Files<cr>
nn <leader>P <cmd>Files ~<cr>
nn <leader>cp <cmd>Files %:p:h<cr>
nn <leader>b <cmd>Buffers<cr>
nn <leader>r <cmd>Rg<cr>
nn <leader>l <cmd>Lines<cr>
nn <leader>cl <cmd>Blines<cr>
nn <leader>A <cmd>Commands<cr>
nn <leader>h <cmd>Helptags<cr>
nn <leader>o <cmd>History<cr>
