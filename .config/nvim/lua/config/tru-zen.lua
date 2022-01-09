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
local map = require("config.utils").map
true_zen.after_mode_ataraxis_on = function ()
	map("c", "bd", "Bclose", {noremap = true})
	-- tmp workaround
	vim.cmd('set nospr')
	vim.cmd('set nosb')
end
true_zen.after_mode_ataraxis_off = function ()
	vim.api.nvim_command("cunmap bd")
	-- tmp workaround
	vim.cmd('set nospr')
	vim.cmd('set nosb')
end
map("n", "<leader>z", "<cmd>TZAtaraxis<cr>q:<c-w>c", {noremap = true})
