aug md_ft
    au!
    au BufWritePre *.md :%s/\s\+$//e
aug END

setl tw=80
setl spell spl=en_us,de spf=~/.vim/spell/en.utf-8.add
nnoremap <buffer> <leader>gp <cmd>silent !pandoc --wrap=preserve --pdf-engine=xelatex -V geometry:margin=2cm % -t pdf \| zathura - &<cr>

" cursive
nnoremap <buffer> gc ciw*"*
vnoremap <buffer> gc c*"*

" bold
nnoremap <buffer> gb ciw**"**
vnoremap <buffer> gb c**"**

" math syntax
nnoremap <buffer> gm ciw$"$
vnoremap <buffer> gm c$"$

" code line
nnoremap <buffer> g` ciw`"`
vnoremap <buffer> g` c`"`
