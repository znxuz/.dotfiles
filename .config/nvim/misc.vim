if has('nvim')
	set guicursor=n-v-c-a:block,i-ci-c:ver1
else
	let &t_EI .= "\<Esc>[2 q"
	let &t_SI .= "\<Esc>[6 q"
	set syntax=on
	set hidden
	set incsearch
	set noesckeys
	set nocompatible
	set backspace=indent,eol,start
	set viminfo+=n~/.vim/viminfo
	set novisualbell noerrorbells
	set t_vb =
	filetype plugin indent on
endif

" basics
	let mapleader=","
	set path+=**
	set number
	set nosc
	set colorcolumn=80
	set exrc secure
	set clipboard=unnamedplus

" search
	set ignorecase
	set smartcase
	set nohls
	nnoremap <leader>/ <cmd>let @/ = ""<cr>

" file management
	set noswapfile
	set nobackup
	set undodir=$HOME/.local/share/nvim/undodir
	set undofile
	nnoremap <leader>ec :e <c-r>=substitute(expand("%:p:h"), getcwd().'/', '', '')<cr>/
	nnoremap <leader>o <cmd>!$BROWSER %&<cr><cr>
	cnoremap <leader>cd <c-r>=expand("%:p:h")<cr>

" autocompletion
	set wildignorecase
	set wildmode=longest,list,full

" stautus line
	function! GetMode()
		let l:mode = toupper(mode())
		return '  '.l:mode.' '
	endfunction
	function! GetSep()
		return ' | '
	endfunction
	set noshowmode
	set laststatus=2
	set statusline=
	set statusline+=%#Pmenu#%{GetMode()}%#LineNr#
	set statusline+=%#Pmenu#%{&readonly?GetSep().'RO\ ':''}%#LineNr#
	set statusline+=%#Pmenu#%{&paste?GetSep().'P\ ':''}%#LineNr#
	set statusline+=%<%{'\ \ '.substitute(getcwd(),\ $HOME,\ '~',\ '')}%{'\ '}
	set statusline+=%{fnamemodify(expand('%:p'),\ ':.')==''?'':GetSep().fnamemodify(expand('%:p'),\ ':.').'\ '}
	set statusline+=%{&modified?GetSep().'[+]':''}
	set statusline+=%=
	set statusline+=%{'\ \ '.&fileformat}%{'\ '.GetSep()}
	set statusline+=%{&fileencoding?&fileencoding:&encoding}%{'\ '.GetSep()}
	set statusline+=%l:%c%{GetSep()}
	set statusline+=%p%%
	set statusline+=\ %#Pmenu#\ %Y%{'\ '}
