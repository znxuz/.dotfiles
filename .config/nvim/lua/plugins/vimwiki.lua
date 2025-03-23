return {
	'vimwiki/vimwiki',
	keys = { { '<leader>ws', '<cmd>VimwikiUISelect<cr>', desc = 'Vimwiki UI select' } },
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
			},
			{
				name = 'work',
				path = '~/Dropbox/notes/work',
				syntax = 'markdown',
				ext = '.md'
			},
			{
				name = 'fhdo',
				path = '~/Dropbox/notes/fh',
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
