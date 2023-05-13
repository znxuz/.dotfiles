" === maximize window toggle ===
let g:maximized_window = 0

fu! g:Maximize_window_toggle()
    if g:maximized_window == 0
	wincmd _ | wincmd |
	let g:maximized_window = 1
    else
	wincmd =
	let g:maximized_window = 0
    endif
endf

fu! g:Check_win_count()
    if winnr('$') == 1
	let g:maximized_window = 0
    endif
endfu

au WinResized * call Check_win_count()

nnoremap <c-w>z <cmd>call Maximize_window_toggle()<cr>
