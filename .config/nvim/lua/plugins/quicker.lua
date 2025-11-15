return {
	'stevearc/quicker.nvim',
	enabled = false,
	opts = {
		use_default_opts = true,
		edit = { enabled = false },
		constrain_cursor = false,
		highlight = {
			treesitter = true,
			lsp = false,
			load_buffers = false,
		},
		trim_leading_whitespace = "false"
	},
}
