" === basics ===
let mapleader=","
set nosc
set ts=4 sw=4
set exrc secure
set clipboard+=unnamedplus
set cc=
set ttm=0

" === search ===
set nohls
set ic scs

" === file management ===
set noswapfile
set nobk
set undodir=$HOME/.local/share/nvim/undodir
set undofile
set aw
nnoremap <leader>o <cmd>silent !$BROWSER %&<cr>
cnoremap <leader>cd <c-r>=substitute(expand("%:p:h"), getcwd(), '.', '').'/'<cr>

" === autocompletion ===
set wic
set wim=longest:list:lastused,full

" === stautus line ===
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
    set ls=3
    lua require('plugins')
else
    " let &t_EI .= "\e[2 q"
    " let &t_SI .= "\e[6 q"
    set syntax=on
    set ls=2
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
