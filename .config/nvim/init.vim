set guicursor=n-v-c-a:hor1-blinkwait300-blinkon200-blinkoff150,i-ci-c:ver1-blinkwait300-blinkon200-blinkoff150
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

" line numbers
set number rnu
nnoremap <leader>rn :set rnu!<CR>

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

" custom statusline
set statusline=
set statusline+=\ %F
set statusline+=%= " right side 
set statusline+=\ %p%%
set statusline+=\ %c:%l/%L
set statusline+=\ [%n]

" vim file management
set noswapfile
set nobackup

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

" add numbered jk to jumplist
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

source $HOME/.config/vim/leaders.vim
source $HOME/.config/vim/cursor.vim
