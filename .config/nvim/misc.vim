" vim specific
	" let &t_EI .= "\<Esc>[4 q"
	" let &t_SI .= "\<Esc>[6 q"
	" set noesckeys
	" set timeoutlen=350 ttimeoutlen=0
	" set viminfo+=n~/.vim/viminfo

" neovim specific
	set guicursor=n-v-c-a:hor1,i-ci-c:ver1

" basics
	let mapleader=","
	set clipboard=unnamedplus
	set novisualbell
	set t_vb =
	set noerrorbells
	set number rnu
	set hidden
	set backspace=indent,eol,start
	set splitright
	set splitbelow
	set cursorline
	set colorcolumn=80

" set expandtab
	set tabstop=4
	set softtabstop=4
	set shiftwidth=4
	set autoindent
	set cindent

" search
	set incsearch
	set nohlsearch
	set ignorecase
	set smartcase
	" nnoremap <silent> // :let @/ = ""<CR>

" jk motion to jumplist
	" nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
	" nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" file management
	set noswapfile
	set nobackup
	set undodir=$HOME/.local/share/undodir
	set undofile

" toggle relative line nb
	nnoremap <leader>rn :set rnu!<CR>

" autocompletion
	set wildignorecase
	set wildmode=longest,list,full
	inoremap <leader><TAB> <C-x><C-f>

" exact word search syntax
	nnoremap <leader>/ /\<\><left><left>

" change working dir
	nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" save session
	nnoremap <C-S> :wa<CR> <BAR> :mks!<CR> <BAR> :qa<CR>

" buffers control
	nnoremap <leader>q :bd<CR>
	nnoremap <leader>Q :bd!<CR>
	nnoremap <leader>h :bprev<CR>
	nnoremap <leader>l :bnext<CR>

" quitting nvim
	nnoremap q :close<CR>
	nnoremap Q :q!<CR>
	nnoremap <leader>rc q

" stautus line
	set noshowmode
	function! GetMode()
		let l:mode = toupper(mode())
		return '  '.l:mode.' '
	endfunction
	function! GetSep()
		return ' | '
	endfunction
	set statusline+=%#Pmenu#%{GetMode()}%#LineNr#
	set statusline+=%#Pmenu#%{&paste?GetSep().'[P]\ ':''}%#LineNr#
	set statusline+=%{'\ \ '.getcwd()}%{'\ '.GetSep()}
	set statusline+=%f%{&modified?GetSep().'[+]':''}
	set statusline+=%=
	set statusline+=%{&fileformat}%{'\ '.GetSep()}
	set statusline+=%{&fileencoding?&fileencoding:&encoding}%{'\ '.GetSep()}
	set statusline+=%l:%c%{GetSep()}
	set statusline+=%p%%
	set statusline+=\ %#Pmenu#\ %y%{'\ '}
