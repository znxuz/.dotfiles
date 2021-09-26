if has('nvim')
	set guicursor=n-v-c-a:block,i-ci-c:ver1
else
	let &t_EI .= "\<Esc>[2 q"
	let &t_SI .= "\<Esc>[6 q"
	set syntax=on
	set hidden
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
	set tabstop=4
	set shiftwidth=4
	set colorcolumn=80
	set ttimeoutlen=0
	set exrc secure
	set clipboard=unnamedplus

" search
	set incsearch
	set nohls
	set ignorecase
	set smartcase
	nnoremap // /\<\><left><left>
	nnoremap <leader>/ <CMD>let @/ = ""<CR>

" file management
	set noswapfile
	set nobackup
	set undodir=$HOME/.local/share/nvim/undodir
	set undofile
	nnoremap <leader>ec :e <C-R>=substitute(expand("%:p:h"), getcwd().'/', '', '')<CR>/
	nnoremap <leader>tw <CMD>%s/\s\+$//e<CR>

" autocompletion
	set wildignorecase
	set wildmode=longest,list,full

" netrw (enabled)
	" let g:loaded_netrw       = 1
	" let g:loaded_netrwPlugin = 1
	let g:netrw_banner = 0
	let g:netrw_winsize = 30
	" let g:netrw_altv = 1
	" let g:netrw_liststyle = 3
	" let g:netrw_browse_split = 4

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
	set statusline+=%<%{'\ \ '.substitute(getcwd(),\ '/home/zijian',\ '~',\ '')}%{'\ '}
	set statusline+=%{fnamemodify(expand('%:p'),\ ':.')==''?'':GetSep()}
	set statusline+=%{fnamemodify(expand('%:p'),\ ':.')}
	set statusline+=%{&modified?'\ '.GetSep().'[+]':''}
	set statusline+=%=
	set statusline+=%{'\ \ '.&fileformat}%{'\ '.GetSep()}
	set statusline+=%{&fileencoding?&fileencoding:&encoding}%{'\ '.GetSep()}
	set statusline+=%l:%c%{GetSep()}
	set statusline+=%p%%
	set statusline+=\ %#Pmenu#\ %Y%{'\ '}
