" === nvim ===
set guicursor=a:block

" === defaults ===
syntax enable
set syn=on
set nu
set hid
set tgc
set bs=indent,eol,nostop
set sta sts=4 sw=4
set ttimeout ttm=1
set cb=unnamedplus
set shada+=n$XDG_STATE_HOME/nvim/viminfo
set fo+=j
set nosc
set lcs=tab:>\ ,trail:-,nbsp:+
set scl=yes
filetype plugin indent on
let g:netrw_dirhistmax = 0

" === leader key ===
let mapleader = " "

" === search ===
set is ic scs nohls

" === file management ===
set ar aw
set noswf
set sbr=>\\
set udf

" === completion ===
set wmnu
set wop=pum
set wic
set wim=longest:full,full
set cpt-=t,i
set cot=menuone,noinsert,noselect,preview
set shm-=S shm+=cF
set ph=10
set ls=2

" === statusline ===
aug stl
    au!
    au VimEnter * hi default link STL StatusLineNC
    au VimEnter * hi default link STLMode WildMenu
    au ModeChanged *:n* hi clear STLMode | redraws!
    au ModeChanged *:i* hi link STLMode DiffText | redraws!
    au ModeChanged *:[vV\x16]* hi link STLMode Visual | redraws!
aug END
set stl=
set stl+=%#STLMode#%{'\ \ '.toupper(mode()).'\ '}%#STL#
set stl+=%#STLMode#%{&readonly?'\ \|\ '.'RO\ ':''}%#STL#
set stl+=%#STLMode#%{&paste?'\ \|\ '.'P\ ':''}%#STL#
set stl+=%<%{'\ \ '.pathshorten(fnamemodify(getcwd(),':~'),1)}
set stl+=%{expand('%')==''?'':'\ \ \|\ '.pathshorten(fnamemodify(expand('%:p'),\ ':~:.'),1)}
set stl+=%{&modified?'\ \ '.'[+]':''}
set stl+=%=
set stl+=%{'\ \ \ \ '.&fileformat}%{'\ \ \|\ '}
set stl+=%{&fileencoding?&fileencoding:&encoding}%{'\ '.'\ \|\ '}
set stl+=%l:%c%{'\ \|\ '}
set stl+=%p%%
set stl+=%{&filetype==''?'\ ':'\ \|\ '.toupper(&filetype).'\ '}

" === plugins ===
lua require('plugins')
