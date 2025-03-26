" === defaults ===
set nu
set sw=0 ts=4
set ttm=1
set cb+=unnamedplus
set tgc
set lcs=tab:│\ ,nbsp:␣,trail:•
set cul
set exrc
set gcr=a:block
set mouse=
set list
set sbr=>\\
filetype plugin indent on
ino <C-b> <Left>
ino <C-f> <Right>

let mapleader = " "

" === undo ===
set shada+=n$HOME/.local/state/nvim/viminfo
set udf

" === completion ===
set wop=pum
set wim=longest:full,full
set cpt-=t
set cot=menuone,preview,noinsert,noselect
set ph=10
ino <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
ino <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

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
	let stl .= "\ \|\ %{&fileencoding?&fileencoding:&encoding}"
	let stl .= "%{&filetype==''?'\ ':'\ \ \|\ '.toupper(&filetype).'\ '}"
	return stl
endfu

set stl=
set stl=%!DefSTL()

" === plugins ===
lua require('config.lazy')
