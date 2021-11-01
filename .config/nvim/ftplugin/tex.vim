set tabstop=4
set shiftwidth=4

autocmd BufWritePost *.tex :!tectonic -o out/ %
