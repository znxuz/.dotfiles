local devdocs = require('nvim-devdocs')

devdocs.setup({
  float_win = { -- passed to nvim_open_win(), see :h api-floatwin
    relative = "editor",
    height = 30,
    width = 100,
    border = "single",
  },
  wrap = false, -- text wrap, only applies to floating window
  previewer_cmd = 'glow', -- for example: "glow"
  cmd_args = { '-s', vim.o.background },
  mappings = { -- keymaps for the doc buffer
    open_in_browser = "go"
  },
})

require('config.mapper').map('n', '<leader>H', function() devdocs.open_doc_current_file(true) end)
require('config.mapper').map('n', '<leader>ch', function() devdocs.toggle() end)
