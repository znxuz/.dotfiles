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
	event = "LspAttach",
	keys = {
		{ "go", "<cmd>AerialToggle<CR>", "n" },
		-- FIXME v:count doesnt work
		{
			"]t",
			function()
				local count = vim.v.count
				if count == 0 then
					vim.cmd("AerialNext")
				else
					vim.cmd(count .. "AerialNext")
				end
			end,
			"n"
		},
		{
			"[t",
			function()
				local count = vim.v.count
				if count == 0 then
					vim.cmd("AerialPrev")
				else
					vim.cmd(count .. "AerialPrev")
				end
			end,
			"n"
		},
	}
}
