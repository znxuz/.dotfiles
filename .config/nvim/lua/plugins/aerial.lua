return {
	'stevearc/aerial.nvim',
	dependencies = "nvim-treesitter/nvim-treesitter",
	opts = {
		layout = {
			max_width = 0.8,
			default_direction = 'float'
		},
		float = { border = 'single', },
		highlight_closest = false,
		highlight_on_jump = false,
		close_on_select = true,
		keymaps = {
			['?'] = false,
			['<C-[>'] = 'actions.close',
		}
	},
	keys = { { "go", "<cmd>AerialToggle<CR>", "n", desc = "Aerial Toggle" } }
}
