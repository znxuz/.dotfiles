return {
	'stevearc/aerial.nvim',
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {
		layout = {
			max_width = 0.8,
			default_direction = 'float'
		},
		highlight_closest = false,
		highlight_on_jump = false,
		keymaps = {
			['?'] = false
		}
	},
	keys = { { "go", "<cmd>AerialToggle<CR>", "n", desc = "Aerial Toggle" } }
}
