return {
	'vimwiki/vimwiki',
	keys = {
		{ '<leader>ww', '<cmd>VimwikiIndex<cr>' },
		{ '<leader>ws', '<cmd>VimwikiUISelect<cr>' }
	},
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

		vim.cmd [[
			nn <c-n> <Plug>VimwikiNextLink
			nn <c-p> <Plug>VimwikiPrevLink
		]]
	end
}
