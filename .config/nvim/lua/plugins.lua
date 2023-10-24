require'lazy'.setup({
  -- almighty picker
  {
    'ibhagwan/fzf-lua',
    config = function () require('config.fzflua') end,
  },

  -- lsp
  {
    'neovim/nvim-lspconfig',
    config = function () require('config.lsp') end
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function ()
      require('config.nvim-cmp')
      require('config.ls')
    end
  },
  {
    'mfussenegger/nvim-jdtls',
    lazy = true
  },

  -- debugger
  {
    'mfussenegger/nvim-dap',
    after = 'nvim-dap-ui',
    lazy = true,
    keys = { '<leader>di' },
    config = function () require('config.nvim-dap') end
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = 'nvim-dap',
    lazy = true,
    keys = { '<leader>di' }
  },

  -- misc
  {
    'mbbill/undotree',
    config = function () vim.cmd('nnoremap <leader>u <cmd>UndotreeToggle<cr>') end
  },
  {
    'vimwiki/vimwiki',
    keys = { { '<leader>ws', '<cmd>VimwikiUISelect<cr>', desc = 'Vimwiki UI select' } },
    init = function () require('config.vimwiki') end
  },
  {
    'romainl/vim-devdocs'
  },
  {
    'norcalli/nvim-colorizer.lua',
    lazy = true,
    config = function () require'colorizer'.setup() end
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function () require('gitsigns').setup() end
  },
  {
    'zijian-x/gruvbox-material',
    config = function () require('config.colors') end
  }
})

