" === configurations ===
syntax enable
set syn=on
set nu
set hid
set bs=indent,eol,nostop
set sw=0 ts=4
set ttimeout ttm=1
set cb=unnamedplus
set tgc
set fo+=j
set nosc
set scl=yes
set sbr=>\\
set list
set lcs=tab:│\ ,nbsp:␣,trail:•
set cul
set nohls
filetype plugin indent on

" === leader key ===
let mapleader = " "

" === case sensitivity ===
" set ic scs wic

" === file management ===
set shada+=n$XDG_STATE_HOME/nvim/viminfo
set udf

" === completion ===
set wop=pum
set wim=longest:full,full
set cpt-=t,i
set cot=menuone,preview,noinsert,noselect
set shm-=S shm+=cF
set ph=10
set ls=2

" === statusline ===
fu! PathReduce(path)
	return fnamemodify(a:path,':~:.')
endfu

fu! ShowDiagnosticCount()
	if luaeval("pcall(function () require('config.lsp').StatuslineDiagCountAll() end)")
		return luaeval('require"config.lsp".StatuslineDiagCountAll()')
	else
		return ""
	endif
endfu

fu! DefSTL() abort
	let stl = ""
	if g:statusline_winid == win_getid(winnr())
		let stl .= "%#STLMode#"
	else
		let stl .= "%#StatusLineNC#"
	endif
	let stl .= "%<\ %{PathReduce(getcwd())}"

	let stl .= "%{expand('%')==''?'':'\ \ \|\ '.PathReduce(expand('%:p'))}"
	let stl .= "%{&modified?'\ \ [+]':''}"
	let stl .= "%{&readonly?'\ \ [RO]':''}"
	let stl .= "%{&paste?'\ \ [P]':''}"
	let stl .= "%{ShowDiagnosticCount()}"
	let stl .= "%="
	let stl .= "\ \ \ \ \ "
	let stl .= "\ \ %{&fileformat}"
	let stl .= "\ \|\ %{&fileencoding?&fileencoding:&encoding}"
	" let stl .= "\ \|\ %l:%c"
	" let stl .= "\ \|\ %p%%"
	let stl .= "%{&filetype==''?'\ ':'\ \ \|\ '.toupper(&filetype).'\ '}"

	return stl
endfu

aug stl
	au!
	au VimEnter * hi default link STLMode StatusLine
	au ModeChanged *:n hi clear STLMode | redraws!
	au ModeChanged *:ni* hi link STLMode Visual | redraws!
	au ModeChanged *:i* hi link STLMode Search | redraws!
	au ModeChanged *:[vV\x16]* hi link STLMode Substitute | redraws!
	au ModeChanged *:R* hi link STLMode CursorLineNr | redraws!
aug END

set nosmd
set stl=
set stl=%!DefSTL()

" === nvim ===
set mouse=
set guicursor=a:block
if exists(':EditQuery')
	delc EditQuery " fucking useless neovim command polluting the shorthand to :Ex
endif

" === netrw ===
let netrw_banner = 0

" === plugins ===
lua require('plugins')
