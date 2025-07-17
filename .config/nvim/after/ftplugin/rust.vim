setl wig+=target/*,Cargo.lock

nn <buffer> <leader>mm <cmd>make! build<cr>
nn <buffer> <leader>mr <cmd>make! run<cr>
nn <buffer> <leader>mR :make! run -- 
nn <buffer> <leader>mk <cmd>make! check<cr>
nn <buffer> <leader>mc <cmd>make! clean<cr>
nn <buffer> <leader>mt <cmd>make! test %:t:r<cr>
nn <buffer> <leader>mT <cmd>make! test<cr>

" for .exrc: auto fmt upon write for .rs files in the current directory
" autocmd BufWritePre *.rs if stridx(simplify(expand('<afile>:p:h') .. '/'), simplify(expand('<sfile>:p:h'))) == 0 | undojoin | RustFmt | endif
