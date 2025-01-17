return {
	'stevearc/oil.nvim',
	enabled = true,
	config = function()
		require("oil").setup({
			keymaps = {
				["<C-v>"] = { "actions.select", opts = { horizontal = true } },
			},
			view_options = { show_hidden = true },
			float = { border = 'single' },
			confirmation = { border = 'single' },
			progress = { border = 'single' },
			ssh = { border = "single" },
			keymaps_help = { border = "single" },
		})

		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end
}
