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
	-- essentials --
	{
		'nvim-telescope/telescope.nvim',
		dependencies = 'nvim-lua/plenary.nvim',
		config = function() require('config.telescope') end
	},
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make'
	},
	{
		"kylechui/nvim-surround",
		event = 'VeryLazy',
		config = true
	},

	-- lsp --
	{
		'neovim/nvim-lspconfig',
		config = function() require('config.lsp') end
	},
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
		},
		config = function()
			require('config.nvim-cmp')
			require('config.ls')
		end
	},
	{
		'mfussenegger/nvim-jdtls',
		lazy = true
	},

	-- misc --
	{
		'vimwiki/vimwiki',
		keys = { { '<leader>ws', '<cmd>VimwikiUISelect<cr>', desc = 'Vimwiki UI select' } },
		init = function() require('config.vimwiki') end
	},
	{
		'romainl/vim-devdocs',
		event = 'LspAttach',
	},
	{
		'lewis6991/gitsigns.nvim',
		config = true,
	},
	{
		'mbbill/undotree',
		config = function()
			require('config.mapper').map('n', '<leader>u', '<cmd>UndotreeToggle<cr>')
		end
	},
	{
		'jbyuki/nabla.nvim',
		dependencies = 'nvim-treesitter/nvim-treesitter',
		lazy = true,
		ft = { 'vimwiki', 'md', 'tex' }
	},
	{
		'norcalli/nvim-colorizer.lua',
		config = true,
		cmd = 'ColorizerAttachToBuffer'
	},
	{
		'nvim-treesitter/nvim-treesitter-context',
		dependencies = 'nvim-treesitter/nvim-treesitter',
		config = function() require('config.ts-context') end,
		event = 'LspAttach',
	},
	{
		'wakatime/vim-wakatime',
		lazy = false,
	},
	{
		"robitx/gp.nvim",
		config = function() require('config.gp') end,
	},

	-- colors --
	{
		'rose-pine/neovim',
		priority = 1000,
		config = function() require('config.colors') end
	},
	{
		'nvim-treesitter/nvim-treesitter',
		config = function() require('config.treesitter') end,
		lazy = true
	},
}, {
	ui = {
		icons = {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
