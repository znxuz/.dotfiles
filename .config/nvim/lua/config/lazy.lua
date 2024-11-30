local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require 'lazy'.setup({
	{ import = 'plugins' },

	{ "kylechui/nvim-surround",  event = 'VeryLazy', config = true },
	{ 'lewis6991/gitsigns.nvim', config = true },
	{ 'mfussenegger/nvim-jdtls', lazy = true },
	{ 'romainl/vim-devdocs',     event = 'LspAttach' },
	{
		'mbbill/undotree',
		keys = { { '<leader>u', '<cmd>UndotreeToggle<cr>', desc = 'Undotree Toggle' } },
	},
	{
		'jbyuki/nabla.nvim',
		dependencies = 'nvim-treesitter/nvim-treesitter',
		ft = { 'vimwiki', 'md', 'tex' }
	},
	{ 'norcalli/nvim-colorizer.lua', cmd = 'ColorizerAttachToBuffer' },
	{ 'wakatime/vim-wakatime',       lazy = false, },
}, {
	lockfile = vim.fn.stdpath('state') .. "/lazy/lazy-lock.json",
	install = { colorscheme = { 'rose-pine' } },
	ui = {
		icons = {
			cmd = "",
			config = "",
			event = "",
			favorite = "",
			ft = "",
			init = "",
			import = "",
			keys = "",
			lazy = "",
			loaded = "",
			not_loaded = "",
			plugin = "",
			runtime = "",
			require = "",
			source = "",
			start = "",
			task = "",
			list = {
				"",
				"",
				"",
				"",
			},
		},
	},
	change_detection = { enabled = false },
})
