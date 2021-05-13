set guicursor=n-v-c-a:hor1,i-ci-c:ver1

" search 
set incsearch
set hlsearch
set ignorecase
set smartcase
nnoremap <silent> // :let @/ = ""<CR>

" move around selection
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" add numbered jk to jumplist
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

nnoremap q <Nop>
nnoremap qr q
nmap Q ZQ
nmap qq ZZ

if exists('g:vscode')
else

    set clipboard=unnamedplus
    set number rnu
    set hidden
    set backspace=indent,eol,start
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set expandtab
    set smartindent
    set scroll=10
    set scrolloff=0

    " autocompletion within vim
    set wildmode=longest,list,full

    " vim file management
    set noswapfile
    set nobackup

    " no error bell sound
    set visualbell
    set t_vb = 
    set noerrorbells
endif
