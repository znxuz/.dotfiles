return {
	'vimwiki/vimwiki',
	keys = {
		{ '<leader>ww', '<cmd>VimwikiIndex<cr>' },
		{ '<leader>wt', '<cmd>VimwikiTabIndex<cr>' },
		{ '<leader>ws', '<cmd>VimwikiUISelect<cr>' }
	},
	ft = 'markdown',
	init = function()
		vim.g.vimwiki_list = {
			{
				name = 'miscellaneous',
				path = '~/Dropbox/notes/misc',
				syntax = 'markdown',
				ext = '.md'
			},
			{
				name = 'compsci',
				path = '~/Dropbox/notes/compsci',
				syntax = 'markdown',
				ext = '.md'
			}
		}
		vim.g.vimwiki_key_mappings = {
			headers = 0,
			lists = 0
		}
		vim.g.vimwiki_hl_cb_checked = 2

		vim.keymap.set('n', '<c-n>', '<Plug>VimwikiNextLink')
		vim.keymap.set('n', '<c-p>', '<Plug>VimwikiPrevLink')
	end
}
