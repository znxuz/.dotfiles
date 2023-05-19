aug tex_ft
    au!
    au BufWritePre *.tex :%s/\s\+$//e
aug END

nnoremap <leader>c <cmd>!tectonic %<cr>
