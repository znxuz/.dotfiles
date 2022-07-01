" === basics ===
let mapleader=" "
set nu
set nosc
set sts=4 sw=4
set bs=indent,eol,nostop
set clipboard+=unnamedplus
set ttm=0
set tgc

" === search ===
set nohls
set ic scs

" === file management ===
set noswf
set nobk
set undofile
set aw

" === wildmode & autocompletion ===
set wic
set wim=longest:full
set cot=menuone,noinsert,noselect,preview

" === stautus line ===
set ls=2
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
    set undodir=~/.local/state/nvim/undodir
    lua require('plugins')
else
    set syntax=on
    set hid
    set is
    set noesckeys
    set nocp
    set viminfo+=n~/.vim/viminfo
    set undodir=~/.vim/undodir
    set novb noeb
    set t_vb =
    filetype plugin indent on
    " let &t_EI .= "\e[2 q"
    " let &t_SI .= "\e[6 q"
endif
