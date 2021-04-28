syntax on

" line numbers
set number rnu

set noesckeys

set hidden
set backspace=indent,eol,start
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set scroll=10
set scrolloff=0
set cursorline
set cursorcolumn

" autocompletion within vim
set wildmode=longest,list,full

" add numbered jk to jumplist
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" basic cp paste
inoremap <C-v> <C-r>+
vnoremap <C-c> "+y

" vim file management
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
set hlsearch
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
