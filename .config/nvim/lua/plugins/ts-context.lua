return {
	'nvim-treesitter/nvim-treesitter-context',
	dependencies = 'nvim-treesitter/nvim-treesitter',
	opts = {
		enable = true,
		multiwindow = false,
		max_lines = 0,
		min_window_height = 0,
		line_numbers = true,
		multiline_threshold = 20,
		trim_scope = 'outer',
		mode = 'cursor',
		separator = nil,
		zindex = 20,
		on_attach = nil,
	},
	keys = { { 'grc', '<cmd>TSContextToggle<cr>', desc = "TSContext toggle" } }
}
