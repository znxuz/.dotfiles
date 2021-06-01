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

" goyo
let g:goyo_width = 82
let g:goyo_linenr = 1
nnoremap <leader>z :Goyo<CR>

set noshowmode

set showtabline=2
let g:lightline#bufferline#show_number = 0
let g:lightline#bufferline#number_separator = ' | '
let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#smart_path = 0
let g:lightline#bufferline#reverse_buffers = 0
let g:lightline#bufferline#unnamed = '[No Name]'
let g:lightline = {
	\ 'colorscheme': 'gruvbox_material',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\			[ 'readonly', 'root_directory', 'modified' ] ]
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
	\ 'component_function': {
	\	'root_directory': 'getcwd'
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
