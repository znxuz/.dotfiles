if has('nvim')
	set guicursor=a:block,i-ci-c:ver1
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
	set path+=**,/usr/include/c++/**1
	set nosc
	set colorcolumn=
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
	set autowrite
	nnoremap <leader>o <cmd>!$BROWSER %&<cr><cr>
	cnoremap <leader>cd <c-r>=GetFileCwd()<cr>
	function! GetFileCwd()
		let l:cwd = substitute(substitute(expand("%:p:h"), getcwd(), '', ''), '/\(.*\)', '\1', '')
		if empty(cwd)
			return ''
		endif
		return l:cwd.'/'
	endfunction

" autocompletion
	set wildignorecase
	set wildmode=longest,list,full

" stautus line
	function! GetMode()
		let l:mode = toupper(mode())
		return '  '.l:mode.' '
	endfunction
	set noshowmode
	set laststatus=2
	set statusline=
	set statusline+=%#Visual#%{GetMode()}%#StatusLineNC#
	set statusline+=%#Visual#%{&readonly?'\ \|\ '.'RO\ ':''}%#StatusLineNC#
	set statusline+=%#Visual#%{&paste?'\ \|\ '.'P\ ':''}%#StatusLineNC#
	set statusline+=%<%{'\ \ '.substitute(getcwd(),\ $HOME,\ '~',\ '')}%{'\ '}
	set statusline+=%{fnamemodify(expand('%:p'),\ ':.')==''?'':'\ \|\ '.fnamemodify(expand('%:p'),\ ':.').'\ '}
	set statusline+=%{&modified?'\ \|\ '.'[+]':''}
	set statusline+=%=
	set statusline+=%{'\ \ '.&fileformat}%{'\ '.'\ \|\ '}
	set statusline+=%{&fileencoding?&fileencoding:&encoding}%{'\ '.'\ \|\ '}
	set statusline+=%l:%c%{'\ \|\ '}
	set statusline+=%p%%
	set statusline+=\ %#Visual#\ %Y%{'\ '}
