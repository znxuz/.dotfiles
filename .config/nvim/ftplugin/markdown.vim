aug md_ft
	au!
	au BufWritePre *.md :%s/\s\+$//e
aug END

setlocal textwidth=80
setlocal scrolloff=10
setlocal spell spelllang=en_us
nnoremap <buffer> <leader>o <cmd>silent !pandoc --pdf-engine=xelatex -V geometry:margin=1cm -N % -t pdf \| zathura - &<cr>
