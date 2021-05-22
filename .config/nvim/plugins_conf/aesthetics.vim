colorscheme gruvbox
set background=dark
" background
function! s:set_bg() " NONE for transparent
	hi Normal guibg=NONE ctermbg=NONE
endfunction
call <SID>set_bg()

" goyo
let g:goyo_width = 120
let g:goyo_linenr = 1
nnoremap <leader>z :Goyo<CR>
autocmd! User GoyoLeave call <SID>set_bg()

set showtabline=2
set noshowmode
let g:lightline = {
	\ 'colorscheme': 'apprentice',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'tabline': {
	\   'left': [ ['buffers'] ],
	\	'right': [ [] ],
	\ },
	\ 'component_expand': {
	\   'buffers': 'lightline#bufferline#buffers'
	\ },
	\ 'component_type': {
	\   'buffers': 'tabsel'
	\ }
\ }
