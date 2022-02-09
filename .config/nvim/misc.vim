if has('nvim')
    set guicursor=a:block
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

" basics
    let mapleader=","
    set path+=**,/usr/include/c++/**1
    set nosc
    set expandtab
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
    aug format_file
        au!
        au BufWritePre * retab!
    aug END

" last argument of the last command
    cnoremap !$ <c-r>=substitute(@:, '.* ', '', '')<cr>

" autocompletion
    set wic
    set wim=longest:list:lastused,full

" stautus line
    set ls=2
    aug stl
        au!
        au ModeChanged * redraws!
        au VimEnter * hi default link STL StatusLineNC
        au VimEnter * hi default link STLMode WildMenu
        au InsertEnter * hi link STLMode DiffText | redraws!
        au CmdlineEnter * hi link STLMode Search | redraws!
        au TermEnter * hi link STLMode IncSearch | redraws!
        au InsertLeave,CmdlineLeave,CmdwinEnter,TermLeave * hi clear STLMode | redraws!
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
