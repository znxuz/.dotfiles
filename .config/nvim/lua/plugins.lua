local packer = require('packer')
packer.reset()
packer.init {
    ensure_dependencies = true,
    compile_on_sync = true
}

packer.startup(function(use)
    use 'wbthomason/packer.nvim'

    -- almighty picker
    use {
	'ibhagwan/fzf-lua',
	config = function () require('config.fzflua') end
    }

    -- lsp
    use {
	'neovim/nvim-lspconfig',
	config = function () require('config.lsp') end
    }
    use {
	'hrsh7th/nvim-cmp',
	requires = {
	    'hrsh7th/cmp-nvim-lsp',
	    'hrsh7th/cmp-buffer',
	    'saadparwaiz1/cmp_luasnip',
	    'L3MON4D3/LuaSnip',
	},
	config = function () require('config.nvim-cmp') end
    }
    use {
	'mfussenegger/nvim-jdtls',
	opt = true
    }

    -- debugger
    use {
	'mfussenegger/nvim-dap',
	after = 'nvim-dap-ui',
	config = function () require('config.nvim-dap') end
    }
    use {
	'rcarriga/nvim-dap-ui',
	requires = 'nvim-dap',
	opt = true,
	keys = '<leader>di'
    }

    -- misc
    use {
	'vimwiki/vimwiki',
	cmd = 'VimwikiUISelect'
    }
    use {
	'mbbill/undotree',
	config = function () vim.cmd('nnoremap <leader>u <cmd>UndotreeToggle<cr>') end
    }
    use {
	'norcalli/nvim-colorizer.lua',
	config = function () require'colorizer'.setup() end
    }
    use {
	'zijian-x/gruvbox-material',
	config = function () require('config.colorscheme') end
    }

    -- mine tweaks
    require('config.general')
end)
