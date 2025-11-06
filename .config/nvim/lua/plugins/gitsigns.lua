return {
	'lewis6991/gitsigns.nvim',
	config = true,
	keys = {
		{ "grb", "<cmd>Gitsigns blame_line<cr>", mode = "n" },
		{ "grB", "<cmd>Gitsigns blame<cr>", mode = "n" },
	},
	event = "VeryLazy"
}
