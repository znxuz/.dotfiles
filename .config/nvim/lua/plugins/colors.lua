return {
	'rose-pine/neovim',
	priority = 1000,
	init = function()
		vim.api.nvim_create_augroup("Update_bg", { clear = false })
		vim.api.nvim_create_autocmd({ "Signal" }, {
			group = "Update_bg",
			pattern = { "SIGUSR1" },
			callback = function() dofile(vim.fn.stdpath('config') .. '/lua/bg.lua') end,
		})
		vim.api.nvim_create_autocmd({ "Signal" }, {
			group = "Update_bg",
			pattern = { "SIGUSR1" },
			command = "hi! default link StatusLine STL"
		})
	end,
	config = function()
		require('bg')
		vim.cmd.colorscheme('rose-pine')
	end
}
