if &ft=="cpp"
    finish
endif

setl cc=80
setl wig+=bin/*,*.o

nn <buffer> <leader>mm <cmd>make<cr>
nn <buffer> <leader>mr <cmd>make run<cr>
nn <buffer> <leader>mcc <cmd>make clean<cr>
nn <buffer> <leader>mcC <cmd>make fclean<cr>
