return {
	'stevearc/oil.nvim',
	enabled = true,
	config = function()
		local oil = require("oil")
		oil.setup({
			keymaps = {
				["<C-v>"] = { "actions.select", opts = { vertical = true } },
				["<C-s>"] = { "actions.select", opts = { horizontal = true } },
				["<C-Space>"] = { "actions.preview", opts = { horizontal = true } },
				["<C-q>"] = function()
					require("oil.actions").send_to_qflist.callback()
					oil.close()
					vim.cmd.copen()
				end,
			},
			preview_win = {
				update_on_cursor_moved = false,
				preview_method = "load"
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
