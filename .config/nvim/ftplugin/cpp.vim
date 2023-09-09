setl cc=80
setl et
setl cino=g0
setl wig+=bin/*,*.o

nn <buffer> <leader>mm <cmd>make<cr>
nn <buffer> <leader>mr <cmd>make && make run<cr>
nn <buffer> <leader>mc <cmd>make clean<cr>
nn <buffer> <leader>mf <cmd>make fclean<cr>
