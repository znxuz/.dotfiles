aug md_ft
    au!
    au BufWritePre *.md :%s/\s\+$//e
aug END

setl tw=80
setl spell spl=en_us,de spf=$XDG_CONFIG_HOME/nvim/spell/en.utf-8.add

fu! g:MD2PDF()
    let s:src = expand('%')
    let s:dest = input("preview or enter the file name with the extension .pdf: ", "preview")
    redraw!

    if empty(s:dest)
	return
    endif

    let s:dir = expand('%:p:h')

    " change to abs. path for inlining pictures inside markdown
    silent! exe '%s;\(!\[.\+\]\)(\([^;~].\+\));\1(' . s:dir . '/\2);'
    silent! w

    let s:pandoc_cmd = 'pandoc --wrap=preserve --number-sections --pdf-engine=xelatex -V geometry:margin=2.54cm '
    if s:dest == "preview"
	call system(s:pandoc_cmd . s:src . ' -t pdf | zathura - ')
    elseif expand(s:dest . ':e') != 'pdf'
	echohl ErrorMsg | echo 'Error: entered file name doesn''t contain a pdf file extension' | echohl None
    else
	call system(s:pandoc_cmd . s:src . ' -t pdf -o ' . s:dest)
    endif

    silent! exe '%s;' . s:dir . '/;;'
    silent! w
endf

nnoremap <buffer> <c-n> <cmd>VimwikiNextLink<cr>
nnoremap <buffer> <c-p> <cmd>VimwikiPrevLink<cr>
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
