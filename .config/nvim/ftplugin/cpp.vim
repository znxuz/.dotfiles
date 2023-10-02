setl cc=80
setl et
setl cino=g0
setl wig+=bin/*,*.o

nn <buffer> <leader>mm <cmd>make<cr>
nn <buffer> <leader>mr <cmd>make run<cr>
nn <buffer> <leader>mR <cmd>make fclean && make run<cr>
nn <buffer> <leader>mcc <cmd>make clean<cr>
nn <buffer> <leader>mcC <cmd>make fclean<cr>
nn <buffer> <leader>mct <cmd>make clean_test<cr>
nn <buffer> <leader>mt <cmd>make test<cr>
