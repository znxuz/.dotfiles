return {
	'nvim-treesitter/nvim-treesitter-context',
	dependencies = 'nvim-treesitter/nvim-treesitter',
	enabled = true,
	config = function()
		require 'treesitter-context'.setup {
			multiwindow = true,
			max_lines = 1,
			line_numbers = true,
			multiline_threshold = 10,
			mode = 'cursor',
			separator = nil,
			zindex = 20,
			on_attach = nil,
		}
		vim.keymap.set('n', 'grc', '<cmd>TSContext toggle<cr>')
	end
}
