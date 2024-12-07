local init = function()
	vim.api.nvim_create_augroup("Update_bg", { clear = false })
	vim.api.nvim_create_autocmd({ "Signal" }, {
		group = "Update_bg",
		pattern = { "SIGUSR1" },
		callback = function() dofile(vim.fn.stdpath('config') .. '/lua/bg.lua') end,
		-- command = "luafile $HOME/.config/nvim/lua/bg.lua"
	})
	vim.api.nvim_create_autocmd({ "Signal" }, {
		group = "Update_bg",
		pattern = { "SIGUSR1" },
		command = "hi! default link StatusLine STL"
	})
end

return {
	{
		'rose-pine/neovim',
		priority = 1000,
		init = init,
		config = function()
			require('bg')
			vim.cmd.colorscheme('rose-pine')
		end
	},
}
