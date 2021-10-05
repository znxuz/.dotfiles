	let g:vimwiki_list = [{
				\ 'path': '~/Dropbox/Documents/vimwiki',
				\ 'syntax': 'markdown', 'ext': '.md', }]

	nnoremap <leader>ww <CMD>VimwikiUISelect<CR>
	nnoremap <leader>l <CMD>VimwikiFollowLink<CR>
	nnoremap <leader>h <CMD>VimwikiGoBackLink<CR>
