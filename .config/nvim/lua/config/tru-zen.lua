local true_zen = require("true-zen")
true_zen.setup {
	ui = {
		left = { signcolumn = "yes", },
	},
	modes = {
		ataraxis = {
			left_padding = 50,
			right_padding = 1,
			auto_padding = false,
			quit = "close",
			ignore_floating_windows = true,
		},
	},
}
true_zen.after_mode_ataraxis_on = function ()
	vim.api.nvim_set_keymap("c", "bd", "Bclose", {noremap = true})
end
true_zen.after_mode_ataraxis_off = function ()
	vim.api.nvim_command("cunmap bd")
end
vim.api.nvim_set_keymap("n", "<leader>z", "<cmd>TZAtaraxis<cr>q:<c-w>c", {noremap = true})
