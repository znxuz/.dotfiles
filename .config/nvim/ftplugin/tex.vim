aug tex_ft
    au!
    au BufWritePre *.tex :%s/\s\+$//e
aug END

nnoremap <buffer> <leader>c <cmd>!tectonic %<cr>
