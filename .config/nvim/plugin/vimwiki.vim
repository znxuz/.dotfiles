" let g:vimwiki_global_ext = 0
let g:vimwiki_list = [
			\ {
				\ 'path': '~/Dropbox/Documents/vimwiki/vimwiki',
				\ 'syntax': 'markdown', 'ext': '.md'
			\ },
			\ {
				\ 'path': '~/Dropbox/FH_Dortmund/notes',
				\ 'syntax': 'markdown', 'ext': '.md'
			\ },
			\ {
				\ 'path': '~/Dropbox/Documents/vimwiki/programming',
				\ 'syntax': 'markdown', 'ext': '.md'
			\ },
			\ {
				\ 'path': '~/Dropbox/Documents/vimwiki/42',
				\ 'syntax': 'markdown', 'ext': '.md'
			\ },
			\ ]

nnoremap <leader>ww <cmd>VimwikiUISelect<cr>
