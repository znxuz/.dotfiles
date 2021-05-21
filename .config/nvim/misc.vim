" basics
set guicursor=n-v-c-a:hor1,i-ci-c:ver1
set clipboard=unnamedplus

set number rnu
set hidden
set backspace=indent,eol,start
set scroll=10
set scrolloff=0
set splitright
set splitbelow
set signcolumn=yes
set cursorline
set colorcolumn=80
" highlight ColorColumn ctermbg=4

" no error bell sound
set visualbell
set t_vb = 
set noerrorbells

" tab
set tabstop=4
set softtabstop=4
set shiftwidth=4
" set expandtab
set smartindent
set cindent

" autocompletion within vim
set wildmode=longest,list,full

" search 
set incsearch
set nohlsearch
set ignorecase
set smartcase
nnoremap <silent> // :let @/ = ""<CR>

" move around selection
" vnoremap J :m '>+1<CR>gv=gv
" vnoremap K :m '<-2<CR>gv=gv

" add numbered jk to jumplist
" nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
" nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" vim file management
set noswapfile
set nobackup
set undodir=$HOME/.local/share/undodir
set undofile

" " navigate splits
" nnoremap <C-h> :wincmd h<CR>
" nnoremap <C-j> :wincmd j<CR>
" nnoremap <C-k> :wincmd k<CR>
" nnoremap <C-l> :wincmd l<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <C-j> gj
nnoremap <C-k> gk

" control buffers
nnoremap q <Nop>
nnoremap qr q
nnoremap Q :bw!<CR>
nnoremap qq :execute 'w' \| :bw<CR>
