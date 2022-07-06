aug tex_ft
    au!
    au BufWritePre *.tex :%s/\s\+$//e
    au BufEnter *.tex set textwidth=80 | set scrolloff=10
    au BufLeave *.tex set textwidth=0 | set scrolloff=0
aug END

nnoremap <leader>c <cmd>!tectonic %<cr>
