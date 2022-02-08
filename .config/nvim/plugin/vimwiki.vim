" let g:vimwiki_global_ext = 0
let g:vimwiki_list = [
			\ {
				\ 'path': '~/Dropbox/notes/misc',
				\ 'syntax': 'markdown', 'ext': '.md'
			\ },
			\ {
				\ 'path': '~/Dropbox/notes/fh',
				\ 'syntax': 'markdown', 'ext': '.md'
			\ },
			\ {
				\ 'path': '~/Dropbox/notes/programming',
				\ 'syntax': 'markdown', 'ext': '.md'
			\ },
			\ ]

nnoremap <leader>ww <cmd>VimwikiUISelect<cr>
