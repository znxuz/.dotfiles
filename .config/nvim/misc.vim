" vim specific
	" set nocompatible
	" let &t_EI .= "\<Esc>[2 q"
	" let &t_SI .= "\<Esc>[6 q"
	" set noesckeys
	" set timeoutlen=350 ttimeoutlen=0
	" set viminfo+=n~/.vim/viminfo

" neovim specific
	set guicursor=n-v-c-a:block,i-ci-c:ver1

" basics
	let mapleader=","
	set path+=**
	set clipboard=unnamedplus
	set number rnu
	set hidden
	set backspace=indent,eol,start
	set splitright
	set splitbelow
	set novisualbell
	set t_vb =
	set noerrorbells
	set colorcolumn=80
	filetype plugin on

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
	nnoremap // /\<\><left><left>
	nnoremap <silent> <leader>/ :let @/ = ""<CR>

" file management
	set noswapfile
	set nobackup
	set undodir=$HOME/.local/share/nvim/undodir
	set undofile

" toggle relative line nb
	nnoremap <leader>rn :set rnu!<CR>

" autocompletion
	set wildignorecase
	set wildmode=longest,list,full
	inoremap <leader><TAB> <C-x><C-f>

" change working dir
	nnoremap <leader>cd :cd %:p:h \| pwd<CR>
	autocmd BufEnter * if isdirectory(expand('%:p')) | :cd %:p:h | :bd

" save session
	nnoremap <C-S> :wa \| mks! \| qa<CR>

" delete buffer while keeping split
	command! BD b# | bd #

" temp
	nnoremap q <NOP>
	nnoremap Q <NOP>
	nnoremap qq q

" stautus line
	function! GetMode()
		let l:mode = toupper(mode())
		return '  '.l:mode.' '
	endfunction
	function! GetSep()
		return ' | '
	endfunction
	set noshowmode
	set statusline=
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
