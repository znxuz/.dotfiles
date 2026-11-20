" === defaults ===

set nu
set sw=0 ts=4
set ttm=1
set cb=unnamedplus
set tgc
set lcs=tab:│\ ,nbsp:␣,trail:•
set cul
set exrc
set gcr=a:block
set mouse=
set list
set sbr=>\\
set nosmd
set jop=view
filetype plugin indent on

let mapleader = " "

" === a lil' bit of readline keybinds doesn't hurt ===

no! <c-b> <left>
no! <c-f> <right>
no! <c-e> <end>
no! <c-a> <home>
no! <m-b> <c-left>
no! <m-f> <c-right>

" === undo ===

set shada+=n$HOME/.local/state/nvim/viminfo
set udf

" === completion ===

set wop=pum
set wim=longest:full:lastused,full
set cpt-=t
set cot=menuone,preview,noinsert
set ph=5
ino <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
ino <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"
ino <expr> <C-_> pumvisible() ? "\<C-e>" : "\<C-_>"
cno <expr> <C-_> pumvisible() ? "\<C-e>" : "\<C-_>"

" === statusline ===

fu! s:SetModeSTL(target) abort
	if a:target ==# ''
		hi clear STL
		hi clear FileHl
		hi clear PrevFileHl
	else
		exe 'hi link STL ' . a:target
		hi link FileHl STL
		hi link PrevFileHl STL
	endif
	redraws
endfu

aug stl
	au!
	au VimEnter * hi default link STL TabLine |
				\ hi! default link StatusLine STL |
				\ hi! default link FileHl SignColumn |
				\ hi! default link PrevFileHl StatusLineNC
	au ModeChanged *:n call s:SetModeSTL('')
	au ModeChanged *:ni* call s:SetModeSTL('Visual')
	au ModeChanged *:i* call s:SetModeSTL('TermCursor')
	au ModeChanged *:[vV\x16]* call s:SetModeSTL('CurSearch')
	au ModeChanged *:R* call s:SetModeSTL('Search')
	au ModeChanged *:no* call s:SetModeSTL('CursorLineNr')
aug END

fu! Shorten(path) abort
	return a:path != '' ? fnamemodify(a:path, ':~:.') : ''
endfu

fu! DefSTL() abort
	let is_active = (g:statusline_winid == win_getid())
	let file_hl = is_active ? '%#FileHl#' : '%#StatusLineNC#'
	let prev_hl = is_active ? '%#PrevFileHl#' : '%#StatusLineNC#'
	let stl = ""
	let stl .= "%<%{Shorten(getcwd())}%{stridx(expand('%:p'), getcwd()) == 0 ? '/' : ' '}"
	let stl .= file_hl . "%{Shorten(expand('%:p'))}%*"
	let stl .= prev_hl . "%{expand('#') == '' ? '' : '  < '.fnamemodify(expand('#:p'),':t')}%*"
	let stl .= "%4m"
	let stl .= "%5r"
	let stl .= "%{&pvw?' [PVW]':''}"
	let stl .= "%{&paste?' [P]':''}"
	let stl .= "%{luaeval(\"require('stl').inject()\")}"
	let stl .= "%="
	let stl .= "     "
	let stl .= "%{&ff}"
	let stl .= "%{&ft==''?' ':'  | '.toupper(&ft).' '}"
	return stl
endfu

set stl=%!DefSTL()

" === netrw ===

"nn - <cmd>Ex<cr>
let g:netrw_list_hide= '*.git,^\.\.\=/\=$'
let g:netrw_banner = 0
let g:netrw_fastbrowse = 0
let g:netrw_altfile = 1
" `netrw_altfile` must be paired with the autocmd below otherwise it won't work properly
aug netrw
	au!
	au FileType netrw setlocal bufhidden=wipe
aug END

" === term ===

aug term
	au!
	au TermOpen * start
	au BufWinEnter,WinEnter term://* start
aug END

tno <A-esc> <c-\><c-n>

" === misc autocmds ===

aug restore_cursor ":h restore-cursor
	au!
	au BufReadPre * au FileType <buffer> ++once
				\ let s:line = line("'\"")
				\ | if s:line >= 1 && s:line <= line("$") && &filetype !~# 'commit'
				\      && index(['xxd', 'gitrebase'], &filetype) == -1
				\      && !&diff
				\ |   execute "normal! g`\""
				\ | endif
aug END

aug highlight_yank
	au!
	au TextYankPost * sil! lua vim.hl.on_yank {timeout = 50}
aug END

aug active_cursorline
	au!
	au WinEnter,BufEnter * setl cul
	au WinEnter,BufEnter *
				\ if getwinvar(winnr(), '&filetype') == 'qf' |
				\   call setwinvar(winnr('#'), '&cul', 1) |
				\ endif
	au WinLeave,BufLeave * setl nocul
aug END

" === plugins ===

lua require('config.lazy')
lua require('keymaps')
lua require('pvw')
lua require('lsp')
