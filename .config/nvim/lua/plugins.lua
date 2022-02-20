local packer = require('packer')
packer.reset()
packer.init {
	ensure_dependencies = true,
	compile_on_sync = true
}

packer.startup(function(use)
	use 'wbthomason/packer.nvim'

	-- aesthetics
	use {
		'sainnhe/gruvbox-material',
		config = 'require("config.colorscheme")'
	}
	use {
		'nvim-treesitter/nvim-treesitter',
		run = 'TSUpdate',
		config = 'require("config.treesitter")'
	}

	-- almighty picker
	use {
		'ibhagwan/fzf-lua',
		config = 'require("config.fzflua")'
	}

	-- lsp
	use {
		'neovim/nvim-lspconfig',
		config = 'require("config.lsp")'
	}
	use {
		'hrsh7th/nvim-cmp',
		requires = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'saadparwaiz1/cmp_luasnip',
			'L3MON4D3/LuaSnip',
		},
		config = 'require("config.nvim-cmp")'
	}
	use 'mfussenegger/nvim-jdtls'

	-- debugger
	use {
		{
			'mfussenegger/nvim-dap',
			opt = true,
			keys = '<leader>di',
			config = 'require("config.nvim-dap")'
		},
		{
			'rcarriga/nvim-dap-ui',
			requires = 'nvim-dap',
		},
	}

	-- misc
	use 'mcchrish/nnn.vim'
	use {
		'voldikss/vim-floaterm',
		config = 'require("config.floaterm")'
	}
	use {
		'vimwiki/vimwiki',
		opt = true,
		cmd = 'VimwikiUISelect'
	}
	use {
		'mbbill/undotree',
		config = 'vim.cmd("nnoremap <leader>u <cmd>UndotreeToggle<cr>")'
	}

end)
