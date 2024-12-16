setl wig+=target/*,Cargo.lock

nn <buffer> <leader>mm <cmd>make build<cr>
nn <buffer> <leader>mr <cmd>make run<cr>
nn <buffer> <leader>mR :make run -- 
nn <buffer> <leader>mch <cmd>make check<cr>
nn <buffer> <leader>mcc <cmd>make clean<cr>
nn <buffer> <leader>mt <cmd>make test %:t:r<cr>
nn <buffer> <leader>mT <cmd>make test<cr>
