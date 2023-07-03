aug md_ft
    au!
    au BufWritePre *.md :%s/\s\+$//e
aug END

setl tw=80
setl spell spl=en_us,de spf=~/.vim/spell/en.utf-8.add

fu! g:MD2PDF()
    let s:src = expand('%')
    let s:target = input("preview or enter the file name with the extension .pdf for the current file: ", "preview")
    if empty(s:target)
	return
    endif

    let s:dir = expand('%:p:h')

    " change to abs. path for pandoc
    execute '%s;\(!\[.\+\]\)(\([^;~].\+\));\1(' .. s:dir .. '/\2);'
    write

    if s:target == "preview"
	call system('pandoc --wrap=preserve --pdf-engine=xelatex -V geometry:margin=2cm ' .. s:src .. ' -t pdf | zathura - ')
    el
	call system('pandoc --wrap=preserve --pdf-engine=xelatex -V geometry:margin=2cm ' .. s:src .. ' -t pdf -o ' .. s:target)
    endif

    execute '%s;' .. s:dir .. '/;;'
    write
endf

nnoremap <buffer> <leader>gp <cmd>silent !pandoc --wrap=preserve --pdf-engine=xelatex -V geometry:margin=2cm % -t pdf \| zathura - &<cr>
nnoremap <buffer> <leader>gp <cmd>call MD2PDF()<cr>

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
