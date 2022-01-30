if has('nvim')
	set guicursor=a:block
else
	" let &t_EI .= "\e[2 q"
	" let &t_SI .= "\e[6 q"
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
	set tabstop=4
	set shiftwidth=4
	set colorcolumn=
	set exrc secure
	set clipboard=unnamedplus

" search
	set ignorecase
	set smartcase
	set nohls

" file management
	set noswapfile
	set nobackup
	set undodir=$HOME/.local/share/nvim/undodir
	set undofile
	set autowrite
	nnoremap <leader>o <cmd>!$BROWSER %&<cr><cr>
	cnoremap <leader>cd <c-r>=substitute(expand("%:p:h"), getcwd(), '.', '').'/'<cr>

" last argument of the last command
	cnoremap !$ <c-r>=substitute(@:, '.* ', '', '')<cr>

" autocompletion
	set wildignorecase
	set wildmode=longest,list,full

" stautus line
	set noshowmode
	set laststatus=2
	au VimEnter * hi link SLMode Visual
	au InsertEnter * hi link SLMode DiffText
	au InsertLeave * hi link SLMode Visual
	set stl=
	set stl+=%#SLMode#%{'\ \ '.toupper(mode()).'\ '}%#StatusLineNC#
	set stl+=%#SLMode#%{&readonly?'\ \|\ '.'RO\ ':''}%#StatusLineNC#
	set stl+=%#SLMode#%{&paste?'\ \|\ '.'P\ ':''}%#StatusLineNC#
	set stl+=%<%{'\ \ '.fnamemodify(getcwd(),':~')}
	" set stl+=%{(expand('#')==expand('%'))\|\|(expand('#')=='')?'':'\ \ \|\ '.fnamemodify(expand('#:p'),\ ':~:.').'\ <-'}
	set stl+=%{expand('%')==''?'':'\ \ \|\ '.fnamemodify(expand('%:p'),\ ':~:.')}
	set stl+=%{&modified?'\ \ '.'[+]':''}
	set stl+=%=
	set stl+=%{'\ \ '.&fileformat}%{'\ \ \|\ '}
	set stl+=%{&fileencoding?&fileencoding:&encoding}%{'\ '.'\ \|\ '}
	set stl+=%l:%c%{'\ \|\ '}
	set stl+=%p%%
	set stl+=%{&filetype==''?'\ ':'\ \|\ '.toupper(&filetype).'\ '}
