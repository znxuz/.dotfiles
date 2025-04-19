return {
	'stevearc/aerial.nvim',
	dependencies = "nvim-treesitter/nvim-treesitter",
	opts = {
		backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
		layout = {
			max_width = { 40 },
			default_direction = 'float'
		},
		float = { border = 'single' },
		highlight_closest = false,
		highlight_on_jump = false,
		close_on_select = true,
		keymaps = {
			['?'] = false,
			['<C-[>'] = 'actions.close',
		},
		post_jump_cmd = false,
	},
	keys = {
		{ "go", "<cmd>AerialToggle<CR>", "n" },
		{ "]t", "v:count == 0 ? ':AerialNext<cr>' : v:count . ':AerialNext<cr>'", "n", expr = true, silent = true },
		{ "[t", "v:count == 0 ? ':AerialPrev<cr>' : v:count . ':AerialPrev<cr>'", "n", expr = true, silent = true },
	}
}
