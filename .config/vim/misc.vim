syntax on

set number rnu
set noesckeys
set hidden
set backspace=indent,eol,start
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
set scroll=10
set scrolloff=0
set cursorline
set clipboard=unnamedplus
set timeoutlen=350 ttimeoutlen=0

set signcolumn=yes
set colorcolumn=80
" highlight ColorColumn ctermbg=4

" autocompletion within vim
set wildmode=longest,list,full

" add numbered jk to jumplist
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" basic cp paste
inoremap <C-v> <C-r>+
vnoremap <C-c> "+y

" move inside a line
nnoremap <C-j> gj
nnoremap <C-k> gk

" file management
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set viminfo+=n~/.vim/viminfo

" no error bell sound
set visualbell
set t_vb = 
set noerrorbells

" search 
set incsearch
set nohlsearch
set ignorecase
set smartcase
nnoremap <silent> // :let @/ = ""<CR>

" move around selection
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" navigate splits
nnoremap <C-h> :wincmd h<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-l> :wincmd l<CR>

nmap q <Nop>
nnoremap qr q
nmap Q :bw!<CR>
nmap qq :execute 'w' \| :bw<CR>

noremap <F3> :Stdheader<CR>
