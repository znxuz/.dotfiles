fu! s:send_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    cope
    cc
endf

let g:fzf_preview_window = []
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.6, 'border' : 'sharp' } }
let g:fzf_action = {
	    \ 'ctrl-q': function('s:send_quickfix_list'),
	    \ 'ctrl-t': 'tab split',
	    \ 'ctrl-x': 'split',
	    \ 'ctrl-v': 'vsplit'
	    \ }
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
	    \ 'header':  ['fg', 'Comment'],
	    \ }

nn <leader>p <cmd>FZF --prompt=FZF>\ <cr>
nn <leader>P <cmd>FZF ~<cr>
nn <leader>cp <cmd>FZF --prompt=FZF>\  %:p:h<cr>
nn <leader>b <cmd>Buffers<cr>
nn <leader>r <cmd>Rg<cr>
nn <leader>A <cmd>Commands<cr>
nn <leader>h <cmd>Helptags<cr>
nn <leader>o <cmd>History<cr>

" map('n', '<leader>cg', '<cmd>FzfLua live_grep cwd=%:p:h<cr>')
" map('n', '<leader>if', '<cmd>lua require("config.fzflua").find_files_in()<cr>')
" map('n', '<leader>ig', '<cmd>lua require("config.fzflua").grep_in()<cr>')
