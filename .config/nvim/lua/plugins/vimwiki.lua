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
				name = 'personal',
				path = '~/Dropbox/notes/personal',
				syntax = 'markdown',
				ext = '.md'
			}
		}
		vim.g.vimwiki_key_mappings = {
			headers = 0,
			lists = 0,
			table_mappings = 0
		}
		vim.g.vimwiki_hl_cb_checked = 2

		vim.keymap.set('n', '<c-n>', '<Plug>VimwikiNextLink')
		vim.keymap.set('n', '<c-p>', '<Plug>VimwikiPrevLink')
		vim.keymap.set('i', '<c-n>', '<Plug>VimwikiTableNextCell')
		vim.keymap.set('i', '<c-p>', '<Plug>VimwikiTablePrevCell')
	end
}
