let g:vimwiki_list = [
	    \ {
	    \ 'path': '~/Dropbox/notes/misc',
	    \ 'syntax': 'markdown', 'ext': '.md'
	    \ },
	    \ {
	    \ 'path': '~/Dropbox/notes/compsci',
	    \ 'syntax': 'markdown', 'ext': '.md'
	    \ },
	    \ {
	    \ 'path': '~/Dropbox/notes/fh',
	    \ 'syntax': 'markdown', 'ext': '.md'
	    \ },
	    \ ]

nnoremap <leader>ws <cmd>VimwikiUISelect<cr>
nnoremap <c-n> <cmd>VimwikiNextLink<cr>
nnoremap <c-p> <cmd>VimwikiPrevLink<cr>

fu! g:Paste_image_from_clip()
    let s:check_xclip_image = "xclip -sel clip -o -t TARGETS | grep -q 'image/png'"
    call system(s:check_xclip_image)
    if v:shell_error
	echohl ErrorMsg | echo 'Error: Clipboard content is not of type image/png' | echohl None
	return
    endif

    let s:image_name = system('echo -n $(date "+%Y-%m-%d_%H-%M-%S")') .. '.png'
    call system('xclip -sel clip -t image/png -o > ' .. '/tmp/' .. s:image_name)
    call system('feh /tmp/' .. s:image_name)
    let s:header_name = input("Enter the header name for this image: ")
    if !empty(s:header_name)
	let s:full_path = expand('%:p:h') .. '/' .. s:image_name
	call system('mv /tmp/' .. s:image_name .. ' ' .. s:full_path)
	if v:shell_error
	    echohl ErrorMsg | echo 'Error: Failed moving the image into the directory of the current file' | echohl None
	    return
	endif
	execute 'norm a![' .. s:header_name .. '](' .. s:full_path .. ')'
    endif
endf

nnoremap <leader>wp <cmd>call Paste_image_from_clip()<cr>
