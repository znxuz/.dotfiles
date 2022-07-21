aug md_ft
    au!
    au BufWritePre *.md :%s/\s\+$//e
aug END

setl tw=80
setl spell spl=en_us,de spf=~/.vim/spell/en.utf-8.add
nnoremap <buffer> <leader>gp <cmd>silent !pandoc --pdf-engine=xelatex -V geometry:margin=2cm -N % -t pdf \| zathura - &<cr>
