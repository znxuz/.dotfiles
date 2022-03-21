" basics
	let mapleader=","
	set nosc
	set tabstop=4
	set shiftwidth=4
	set cc=
	set exrc secure
	set clipboard+=unnamedplus
	set ttm=0

" search
	set ignorecase
	set scs
	set nohls

" file management
	set noswapfile
	set nobk
	set undodir=$HOME/.local/share/nvim/undodir
	set undofile
	set aw
	nnoremap <leader>o <cmd>!$BROWSER %&<cr><cr>
	cnoremap <leader>cd <c-r>=substitute(expand("%:p:h"), getcwd(), '.', '').'/'<cr>

" autocompletion
	set wic
	set wim=longest:list:lastused,full

" stautus line
	if has('nvim')
		set ls=3
	else
		set ls=2
	endif
	aug stl
		au!
		au VimEnter * hi default link STL StatusLineNC
		au VimEnter * hi default link STLMode WildMenu
		au ModeChanged *:n* hi clear STLMode | redraws!
		au ModeChanged *:i* hi link STLMode DiffText | redraws!
		au ModeChanged *:[vV\x16]* hi link STLMode Substitute | redraws!
	aug END
	set stl=
	set stl+=%#STLMode#%{'\ \ '.toupper(mode()).'\ '}%#STL#
	set stl+=%#STLMode#%{&readonly?'\ \|\ '.'RO\ ':''}%#STL#
	set stl+=%#STLMode#%{&paste?'\ \|\ '.'P\ ':''}%#STL#
	set stl+=%<%{'\ \ '.fnamemodify(getcwd(),':~')}
	set stl+=%{expand('%')==''?'':'\ \ \|\ '.fnamemodify(expand('%:p'),\ ':~:.')}
	set stl+=%{&modified?'\ \ '.'[+]':''}
	set stl+=%=
	set stl+=%{'\ \ \ \ '.&fileformat}%{'\ \ \|\ '}
	set stl+=%{&fileencoding?&fileencoding:&encoding}%{'\ '.'\ \|\ '}
	set stl+=%l:%c%{'\ \|\ '}
	set stl+=%p%%
	set stl+=%{&filetype==''?'\ ':'\ \|\ '.toupper(&filetype).'\ '}

if has('nvim')
	set guicursor=a:block
	lua require('plugins')
else
	" let &t_EI .= "\e[2 q"
	" let &t_SI .= "\e[6 q"
	set syntax=on
	set hid
	set is
	set noesckeys
	set nocp
	set backspace=indent,eol,start
	set viminfo+=n~/.vim/viminfo
	set novisualbell noerrorbells
	set t_vb =
	filetype plugin indent on
endif
