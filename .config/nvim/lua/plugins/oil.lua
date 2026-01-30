return {
	'stevearc/oil.nvim',
	enabled = true,
	config = function()
		local oil = require("oil")
		local actions = require("oil.actions")
		oil.setup({
			default_file_explorer = true, -- set false and then run `set spell` to let netrw to download the spellfiles
			keymaps = {
				["gs"] = false,
				["<C-v>"] = { "actions.select", opts = { vertical = true } },
				["<C-s>"] = { "actions.select", opts = { horizontal = true } },
				["<C-p>"] = { "actions.preview", opts = { horizontal = true } },
				["<C-q>"] = function() actions.send_to_qflist.callback({ action = ' ', target = 'loclist' }) end,
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

		vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
		vim.cmd.cabbr({ args = { "<expr>", "%", "&filetype == 'oil' ? bufname('%')[6:] : '%'" } })
	end
}
