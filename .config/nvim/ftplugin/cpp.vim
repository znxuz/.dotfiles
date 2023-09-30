setl cc=80
setl et
setl cino=g0
setl wig+=bin/*,*.o

nn <buffer> <leader>mm <cmd>make<cr>
nn <buffer> <leader>mr <cmd>make run<cr>
nn <buffer> <leader>mR <cmd>make fclean && make run<cr>
nn <buffer> <leader>mc <cmd>make clean<cr>
nn <buffer> <leader>mC <cmd>make fclean<cr>
