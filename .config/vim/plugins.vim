call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'junegunn/goyo.vim'
call plug#end()

nnoremap <leader>c :Goyo<CR>

set laststatus=2
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ }

colorscheme gruvbox
set background=dark
" when using transparent terminal background
" hi Normal guibg=NONE ctermbg=NONE
" set colorcolumn=80
" highlight ColorColumn ctermbg=4

let g:ranger_replace_netrw = 1
