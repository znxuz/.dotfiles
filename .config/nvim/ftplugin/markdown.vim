set tabstop=2
set shiftwidth=2

autocmd BufWritePre *.md :%s/\s\+$//e
