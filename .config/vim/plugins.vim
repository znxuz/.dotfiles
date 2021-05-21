call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
Plug 'yegappan/mru'
Plug 'junegunn/fzf'
Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
call plug#end()

" goyo centering
nnoremap <leader>c :Goyo<CR>

" lightline
set laststatus=2
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ }

" mhm gruv
colorscheme gruvbox
set background=dark
" when using transparent terminal background
" hi Normal guibg=NONE ctermbg=NONE

" last files
nnoremap qQ :MRU<CR>
let MRU_File = '$HOME/.vim/.vim_mru_files'

" nerdtree
nnoremap <leader>e :NERDTreeToggle<CR>
" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" FZF
nnoremap <C-p> :FZF<CR>
nnoremap <C-S-p> :FZF ~<CR>
let g:fzf_layout = { 'down': '15%' }
