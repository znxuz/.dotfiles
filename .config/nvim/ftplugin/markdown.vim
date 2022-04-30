aug md_ft
    au!
    au BufWritePre *.md :%s/\s\+$//e
aug END

setl tw=80
setl so=10
setl spell spl=en_us,de spf=/home/zijian/.local/share/nvim/spell/en.utf-8.add
nnoremap <buffer> <leader>o <cmd>silent !pandoc --pdf-engine=xelatex -V geometry:margin=1cm -N % -t pdf \| zathura - &<cr>
