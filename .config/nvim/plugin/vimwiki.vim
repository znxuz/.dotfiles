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

let g:vimwiki_key_mappings =
	    \ {
	    \ 'headers': 0,
	    \ }

nnoremap <leader>ws <cmd>VimwikiUISelect<cr>
