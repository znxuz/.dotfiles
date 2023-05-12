" === maximize window toggle ===
let g:maximized_window = 0
fu! g:Maximize_window_toggle()
    if g:maximized_window == 0
	execute "norm \<c-w>_ \<c-w>|"
	let g:maximized_window = 1
    else
	execute "norm \<c-w>="
	let g:maximized_window = 0
    endif
endf
nnoremap <leader>z <cmd>call Maximize_window_toggle()<cr>
