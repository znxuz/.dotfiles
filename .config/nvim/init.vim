" === defaults ===
syntax enable
set syn=on
set nu
set hid
set bs=indent,eol,nostop
set sta sts=4 sw=4
set ttimeout ttm=1
set cb=unnamedplus
set shada+=n$XDG_STATE_HOME/nvim/viminfo
set tgc
set fo+=j
set nosc
set scl=yes
set sbr=>\\
set list
filetype plugin indent on
let g:netrw_dirhistmax = 0

" === leader key ===
let mapleader = " "

" === search ===
set is ic scs nohls

" === file management ===
set ar aw
set noswf
set udf

" === completion ===
set wmnu
set wop=pum
set wic
set wim=longest:full,full
set cpt-=t,i
set cot=menuone,preview,noinsert,noselect
set shm-=S shm+=cF
set ph=10
set ls=2

" === statusline ===
fu! FormatPath(path)
    return pathshorten(fnamemodify(a:path,':~:.'), 1)
endfu

fu! ShowDiagnosticCount()
    return luaeval('require"config.lsp".StatuslineDiagCountAll()')
endf

aug stl
    au!
    au VimEnter * hi default link STLMode StatusLineNC
    au ModeChanged *:n hi clear STLMode | redraws!
    au ModeChanged *:ni* hi link STLMode StatusLine | redraws!
    au ModeChanged *:i* hi link STLMode Search | redraws!
    au ModeChanged *:[vV\x16]* hi link STLMode Substitute | redraws!
aug END
set stl=
set stl+=%#STLMode#
set stl+=%<\ %{FormatPath(getcwd())}
set stl+=%{expand('%')==''?'':'\ \ \|\ '.FormatPath(expand('%:p'))}
set stl+=%{&modified?'\ \ [+]':''}
set stl+=%{&readonly?'\ \ [RO]':''}
set stl+=%{&paste?'\ \ [P]':''}
set stl+=%{ShowDiagnosticCount()}
set stl+=%=
set stl+=\ \ %{&fileformat}
set stl+=\ \|\ %{&fileencoding?&fileencoding:&encoding}
set stl+=\ \|\ %l:%c
set stl+=\ \|\ %p%%
set stl+=%{&filetype==''?'\ ':'\ \|\ '.toupper(&filetype).'\ '}
set nosmd

" === qflist ===
nn [c <cmd>cprev<cr>
nn ]c <cmd>cnext<cr>
nn [C <cmd>cfir<cr>
nn ]C <cmd>clast<cr>

" === nvim ===
set mouse=
set guicursor=a:block


" === last cursor ===
autocmd BufRead * autocmd FileType <buffer> ++once
  \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif

" === plugins ===
lua require('plugins')
