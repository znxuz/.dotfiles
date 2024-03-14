require'lazy'.setup({
  -- almighty picker
  {
    'ibhagwan/fzf-lua',
    config = function () require('config.fzflua') end,
  },

  {
    'nvim-tree/nvim-tree.lua',
    config = function() require('config.nvim-tree') end
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

  -- misc
  {
    'nvim-treesitter/nvim-treesitter',
    config = function () require('config.treesitter') end
  },
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
    'jbyuki/nabla.nvim',
    ft = { 'vimwiki', 'md', 'tex' }
  },
  { 'romainl/vim-devdocs' },
  {
    'norcalli/nvim-colorizer.lua',
    config = function () require'colorizer'.setup() end
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function () require('gitsigns').setup() end
  },
  {
    'rose-pine/neovim',
    config = function () require('config.colors') end
  },
})

