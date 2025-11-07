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
filetype plugin indent on

let mapleader = " "

" === a lil' bit of readline keybinds doesn't hurt ===

nn gb :ls<cr>:b<space>
ino <c-b> <left>
ino <c-f> <right>
cno <c-b> <left>
cno <c-f> <right>
cno <m-b> <c-left>
cno <m-f> <c-right>

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

fu! LuaStlCallback()
	try
		return luaeval('require("stl").inject()')
	catch /.*/
		return ""
	endtry
endfu

fu! DefSTL() abort
	let stl = ""
	let stl .= "%<\ %{fnamemodify(getcwd(),':~:.')}"
	let stl .= "%{expand('%')==''?'':'\ \ \|\ '.fnamemodify(expand('%:p'),':~:.')}"
	let stl .= "%4m"
	let stl .= "%5r"
	let stl .= "%{&paste?'\ \ [P]':''}"
	let stl .= "%{LuaStlCallback()}"
	let stl .= "%="
	let stl .= "\ \ \ \ \ "
	let stl .= "%{&fileformat}"
	let stl .= "%{&filetype==''?'\ ':'\ \ \|\ '.toupper(&filetype).'\ '}"
	return stl
endfu

set stl=%!DefSTL()

" === netrw ===

nn - <cmd>Ex<cr>
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

nn <A-enter> <cmd>sp<bar>if expand('%') != ''<bar>lcd %:h<bar>endif<bar>term<CR>
tno <c-\><c-^> <c-\><c-n><c-^>
tno <c-\>h <c-\><c-n><c-w>h
tno <c-\><c-h> <c-\><c-n><c-w>h
tno <c-\>j <c-\><c-n><c-w>j
tno <c-\><c-j> <c-\><c-n><c-w>j
tno <c-\>k <c-\><c-n><c-w>k
tno <c-\><c-k> <c-\><c-n><c-w>k
tno <c-\>l <c-\><c-n><c-w>l
tno <c-\><c-l> <c-\><c-n><c-w>l
tno <c-\>c <c-\><c-n><c-w>c
tno <c-\><c-c> <c-\><c-n><c-w>c

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
  au TextYankPost * lua vim.highlight.on_yank({timeout = 25, visual = true})
aug END

aug active_cursorline
  au!
  au WinEnter,BufEnter * setl cul
  au WinLeave,BufLeave * setl nocul
aug END

" === plugins ===

lua require('config.lazy')
lua require('lsp')
