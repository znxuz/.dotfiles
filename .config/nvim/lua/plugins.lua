require'lazy'.setup({
  -- almighty picker
  {
    'ibhagwan/fzf-lua',
    config = function () require('config.fzflua') end
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
    'vimwiki/vimwiki',
    keys = { { '<leader>ws', '<cmd>VimwikiUISelect<cr>', desc = 'Vimwiki UI select' } },
    init = function () require('config.vimwiki') end
  },
  {
    'numToStr/Comment.nvim',
    config = true,
  },
  {
    'lewis6991/gitsigns.nvim',
    config = true,
  },
  {
    'mbbill/undotree',
    config = function () vim.cmd('nnoremap <leader>u <cmd>UndotreeToggle<cr>') end
  },
  {
    'jbyuki/nabla.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', },
    ft = { 'vimwiki', 'md', 'tex' }
  },
  {
    'norcalli/nvim-colorizer.lua',
    main = colorizer,
    config = true,
  },

  -- colortheme
  {
    'rose-pine/neovim',
    config = function () require('config.colors') end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    config = function () require('config.treesitter') end,
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

