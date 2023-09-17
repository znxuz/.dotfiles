setl tw=80
setl spell spl=en_us,de spf=$XDG_CONFIG_HOME/nvim/spell/en.utf-8.add

fu! g:MD2PDF()
    let l:src = expand('%')
    let l:dest = input("preview or enter the file name with the extension .pdf: ", "preview")
    redraw!

    if empty(l:dest)
	return
    endif

    let l:dir = expand('%:p:h')

    " change to abs. path for inlining pictures inside markdown
    silent! exe '%s;\(!\[.\+\]\)(\([^;~].\+\));\1(' . l:dir . '/\2);'
    silent! w


    let l:pandoc_cmd = 'pandoc --metadata-file=$HOME/.config/pandoc/headers.yml -H $HOME/.config/pandoc/header_includes.tex --tab-stop=8 --pdf-engine=xelatex '
    if l:dest == "preview"
	let l:dest = '/tmp/vimwiki_' . l:dest . '.pdf'

	call system('sudo rm -f ' . l:dest)
	let l:ret = system(l:pandoc_cmd . l:src . ' -t pdf -o ' . l:dest)
	if v:shell_error == 0
	    call system('zathura --fork ' . l:dest)
	else
	    echohl ErrorMsg | echo l:ret | echohl None
	endif
    else
	call system(l:pandoc_cmd . l:src . ' -t pdf -o ' . l:dest)
	if v:shell_error == 1
	    echohl ErrorMsg | echo l:ret | echohl None
	endif
    endif

    silent! exe '%s;' . l:dir . '/;;'
    silent! w
endf

fu! g:Paste_image_from_clip()
    call system("xclip -sel clip -o -t TARGETS | grep -q 'image/png'")
    if v:shell_error
	echohl ErrorMsg | echo 'Error: Clipboard content is not of type image/png' | echohl None
	return
    endif

    let l:image_name = system('echo -n $(date "+%Y-%m-%d_%H-%M-%S")') .. '.png'
    call system('xclip -sel clip -t image/png -o > ' .. '/tmp/' .. l:image_name)
    call system('feh /tmp/' .. l:image_name)
    let l:header_name = input("Enter the header name for this image: ")
    if !empty(l:header_name)
	call system('mv /tmp/' .. l:image_name .. ' ' .. expand('%:p:h') .. '/' .. l:image_name)
	if v:shell_error
	    echohl ErrorMsg | echo 'Error: Failed moving the image into the directory of the current file' | echohl None
	    return
	endif
	execute 'norm a<br>![' .. l:header_name .. '](' .. l:image_name .. ')<br>'
    endif
endf

nnoremap <buffer> <c-n> <cmd>VimwikiNextLink<cr>
nnoremap <buffer> <c-p> <cmd>VimwikiPrevLink<cr>
nnoremap <buffer> <leader>gp <cmd>call MD2PDF()<cr>
nnoremap <buffer> <leader>wp <cmd>call Paste_image_from_clip()<cr>

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
