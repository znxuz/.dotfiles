" gruvbox-material config
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_enable_bold = 0
let g:gruvbox_material_enable_italic = 0
let g:gruvbox_material_disable_italic_comment = 0
let g:gruvbox_material_sign_column_background = 'none'
let g:gruvbox_material_statusline_style = 'default'
let g:gruvbox_material_lightline_disable_bold = 1
colorscheme gruvbox-material
set background=dark
" background
function! s:set_bg() " NONE for transparent
	hi Normal guibg=NONE ctermbg=NONE
endfunction
" call <SID>set_bg()

" goyo
let g:goyo_width = 82
let g:goyo_linenr = 1
nnoremap <leader>z :Goyo<CR>
" autocmd! User GoyoLeave call <SID>set_bg()

set showtabline=2
set noshowmode
let g:lightline#bufferline#show_number = 2
let g:lightline#bufferline#number_separator = ' | '
let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#smart_path = 1
let g:lightline#bufferline#reverse_buffers = 0
let g:lightline#bufferline#unnamed = '[No Name]'
" let g:lightline#bufferline#number_map = {
" "\ 0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
" "\ 5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'}
let g:lightline = {
	\ 'colorscheme': 'gruvbox_material',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\			[ 'readonly', 'relativepath', 'modified' ] ]
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
	\ },
\ }

nmap <A-1> <Plug>lightline#bufferline#go(1)
nmap <A-2> <Plug>lightline#bufferline#go(2)
nmap <A-3> <Plug>lightline#bufferline#go(3)
nmap <A-4> <Plug>lightline#bufferline#go(4)
nmap <A-5> <Plug>lightline#bufferline#go(5)
nmap <A-6> <Plug>lightline#bufferline#go(6)
nmap <A-7> <Plug>lightline#bufferline#go(7)
nmap <A-8> <Plug>lightline#bufferline#go(8)
nmap <A-9> <Plug>lightline#bufferline#go(9)
nmap <A-0> <Plug>lightline#bufferline#go(10)
