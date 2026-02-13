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

aug stl
	au!
	au VimEnter * hi default link STL TabLine | hi! default link StatusLine STL
	au ModeChanged *:n hi clear STL | redraws!
	au ModeChanged *:ni* hi link STL Visual | redraws!
	au ModeChanged *:i* hi link STL TermCursor | redraws!
	au ModeChanged *:[vV\x16]* hi link STL CurSearch | redraws!
	au ModeChanged *:R* hi link STL CursorLineNr | redraws!
	au ModeChanged *:no* hi link STL Search | redraws!
aug END

fu! DefSTL() abort
	let stl = ""
	let stl .= "%<\ %{fnamemodify(getcwd(),':~:.')}"
	let stl .= "%{expand('%')==''?'':'\ \ \|\ '.fnamemodify(expand('%:p'),':~:.')}"
	let stl .= "%4m"
	let stl .= "%5r"
	let stl .= "%{&pvw?'\ \ [PVW]':''}"
	let stl .= "%{&paste?'\ \ [P]':''}"
	let stl .= "%{luaeval(\"require('stl').inject()\")}"
	let stl .= "%="
	let stl .= "\ \ \ \ \ "
	let stl .= "%{&ff}"
	let stl .= "%{&ft==''?'\ ':'\ \ \|\ '.toupper(&ft).'\ '}"
	return stl
endfu
fu! s:ClearPreviewStl()
	for i in range(1, winnr('$'))
		if getwinvar(i, '&pvw')
			call setwinvar(i, '&stl', ' ')
			return
		end
	endfor
endfu

aug set_pvw_stl
	au!
	au BufWinEnter * call s:ClearPreviewStl()
aug END

set stl=%!DefSTL()

" === netrw ===

" disable netrw
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
"nn - <cmd>Ex<cr>
"let g:netrw_list_hide= '*.git,^\.\.\=/\=$'
"let g:netrw_banner = 0
"let g:netrw_fastbrowse = 0
"let g:netrw_altfile = 1
"" `netrw_altfile` must be paired with the autocmd below otherwise it won't work properly
"aug netrw
"	au!
"	au FileType netrw setlocal bufhidden=wipe
"aug END

" === term ===

aug term
	au!
	au TermOpen * start
	au BufWinEnter,WinEnter term://* start
aug END

tno <A-6> <c-\><c-n><c-^>
tno <A-h> <c-\><c-n><c-w>h
tno <A-j> <c-\><c-n><c-w>j
tno <A-k> <c-\><c-n><c-w>k
tno <A-l> <c-\><c-n><c-w>l
tno <A-c> <c-\><c-n><c-w>c

" === misc autocmds ===

" :h restore-cursor
aug restore_cursor
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
	au TextYankPost * sil! lua vim.hl.on_yank {timeout = 25}
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
lua require('lsp')
