setl cc=80
set cino=g0

nnoremap <buffer> <leader>mm <cmd>make<cr>
nnoremap <buffer> <leader>mr <cmd>make && make run<cr>
nnoremap <buffer> <leader>mc <cmd>make clean<cr>
nnoremap <buffer> <leader>mf <cmd>make fclean<cr>
