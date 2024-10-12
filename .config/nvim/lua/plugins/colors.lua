local config = function()
	vim.api.nvim_create_augroup("Update_bg", {})
	vim.api.nvim_create_autocmd({ "Signal" }, {
		group = "Update_bg",
		pattern = { "SIGUSR1" },
		command = "luafile $HOME/.config/nvim/lua/bg.lua"
	})
	vim.api.nvim_create_autocmd({ "Signal" }, {
		group = "Update_bg",
		pattern = { "SIGUSR1" },
		command = "hi! default link StatusLine STL"
	})

	vim.cmd.colorscheme('rose-pine')
end

return {
	{
		'rose-pine/neovim',
		priority = 1000,
		init = function () require('bg') end,
		config = config,
	},
}
