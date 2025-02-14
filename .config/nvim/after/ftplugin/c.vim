setl cc=80
" setl cino=g0,E-s,N-s,:0,l1
setl cino=h1,l1,g1,t0,i4,+4,(0,w1,W4,E-s,N-s
setl wig+=bin/*,*.o
setl et ts& sts=2 sw=2

nn <buffer> <leader>mm <cmd>make!<cr><cr>
nn <buffer> <leader>mr <cmd>make! run<cr><cr>
nn <buffer> <leader>mt <cmd>make! test<cr><cr>
nn <buffer> <leader>mc <cmd>make! clean<cr><cr>
nn <buffer> <leader>mR <cmd>make! fclean && make run<cr><cr>
nn <buffer> <leader>mf <cmd>make! flash<cr><cr>
nn <buffer> <leader>MF <cmd>make! reflash<cr><cr>

nn <buffer> <leader>Mm <cmd>make<cr>
nn <buffer> <leader>Mr <cmd>make run<cr>
nn <buffer> <leader>Mt <cmd>make test<cr>
nn <buffer> <leader>Mc <cmd>make clean<cr>
nn <buffer> <leader>MR <cmd>make fclean && make run<cr>
nn <buffer> <leader>Mf <cmd>make flash<cr>
nn <buffer> <leader>MF <cmd>make reflash<cr>
