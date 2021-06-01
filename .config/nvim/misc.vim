" basics
let mapleader=","

" neovim specific
set termguicolors
set guicursor=n-v-c-a:hor1,i-ci-c:ver1

set clipboard=unnamedplus
set novisualbell
set t_vb = 
set noerrorbells
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
" highlight ColorColumn ctermbg=1d2021

" set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set cindent

" search
set incsearch
set ignorecase
set smartcase
set nohlsearch
" nnoremap <silent> // :let @/ = ""<CR>

" add numbered jk to jumplist
" nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
" nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" vim file management
set noswapfile
set nobackup
set undodir=$HOME/.local/share/undodir
set undofile

" toggle relative line nb
nnoremap <leader>rn :set rnu!<CR>

" autocompletion
set wildignorecase
set wildmode=longest,list,full
inoremap <leader><Tab> <C-x><C-f>

" exact word search syntax
nnoremap <leader>/ /\<\><left><left>

" change working dir
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" session
nnoremap <C-S> :wa<CR> <BAR> :mks<CR> <BAR> :qa<CR>

" splits constrol
" focus
nnoremap <C-h> :wincmd h<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-l> :wincmd l<CR>
" move
nnoremap <C-A-h> :wincmd H<CR>
nnoremap <C-A-j> :wincmd J<CR>
nnoremap <C-A-k> :wincmd K<CR>
nnoremap <C-A-l> :wincmd L<CR>
" resize
nnoremap <C-A-]> :vertical resize +5<CR>
nnoremap <C-A-[> :vertical resize -5<CR>

" buffers control
nnoremap <A-q> :Bclose<CR>
nnoremap <A-S-q> :Bclose!<CR>
nnoremap <A-h> :bprev<CR>
nnoremap <A-l> :bnext<CR>

" quitting nvim
nnoremap q :close<CR>
nnoremap Q :q!<CR>
nnoremap <leader>r q
