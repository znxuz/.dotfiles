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
			},
			{
				name = 'work',
				path = '~/Dropbox/notes/work',
				syntax = 'markdown',
				ext = '.md'
			}
		}
		vim.g.vimwiki_key_mappings = {
			headers = 0,
			lists = 0,
			table_mappings = 0,
			links = 0
		}
		vim.g.vimwiki_hl_cb_checked = 2
	end
}
