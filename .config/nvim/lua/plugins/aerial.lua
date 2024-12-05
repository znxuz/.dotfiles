return {
	'stevearc/aerial.nvim',
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {
		layout = {
			default_direction = 'float'
		},
		highlight_closest = false,
		highlight_on_jump = false,
		keymaps = {
			['?'] = false
		}
	},
	keys = { { "go", "<cmd>AerialToggle<CR>", "n" } }
}
