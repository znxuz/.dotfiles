let g:vimwiki_list = [
	    \ {
		\ 'path': '~/Dropbox/notes/misc',
		\ 'syntax': 'markdown', 'ext': '.md'
		\ },
		\ {
		    \ 'path': '~/Dropbox/notes/programming',
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
