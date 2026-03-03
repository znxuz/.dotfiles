return {
	'lewis6991/gitsigns.nvim',
	config = true,
	keys = {
		{ "grb", "<cmd>Gitsigns blame_line<cr>", mode = "n" },
		{ "grB", "<cmd>Gitsigns blame<cr>", mode = "n" },
		-- TODO overload [c, ]c mapping but weak, so that diff view's mappings stay unchanged
	},
	event = "VeryLazy"
}
