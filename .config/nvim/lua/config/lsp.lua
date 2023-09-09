local map = require('config.utils').map
local lspconfig = require('lspconfig')

vim.cmd 'set shortmess+=c'
vim.cmd 'set signcolumn=yes'

-- lsp mappings
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(_)
    map('n', 'gd', '<cmd>FzfLua lsp_definitions<cr>', { buffer = true })
    map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', { buffer = true })
    map('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<cr>', { buffer = true })
    map('n', 'gr', '<cmd>FzfLua lsp_references<cr>', { buffer = true })
    map('i', '<c-h>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { buffer = true })
    map('n', '<leader>d', '<cmd>FzfLua lsp_typedefs<cr>', { buffer = true })
    map('n', '<leader>aa', '<cmd>FzfLua lsp_code_actions<cr>', { buffer = true })
    map('n', '<leader>ar', '<cmd>lua vim.lsp.buf.rename()<cr>', { buffer = true })
    map('n', '<leader>s', '<cmd>FzfLua lsp_document_symbols<cr>', { buffer = true })
    map('n', '<leader>S', '<cmd>FzfLua lsp_live_workspace_symbols<cr>', { buffer = true })
    map('n', '<leader>E', '<cmd>FzfLua lsp_workspace_diagnostics<cr>', { buffer = true })
    map('n', '<leader>e', '<cmd>FzfLua lsp_document_diagnostics<cr>', { buffer = true })
    map('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<cr>', { buffer = true })
    map('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<cr>', { buffer = true })
    map('n', '<leader>ce', '<cmd>lua vim.diagnostic.open_float()<cr>', { buffer = true })
    map('n', '<leader>ai', '<cmd>lua vim.lsp.inlay_hint(0)<cr>', { buffer = true })

    map('n', '<leader><c-^>', '<cmd>ClangdSwitchSourceHeader<cr>')
  end,
})

-- clangd
lspconfig.clangd.setup { cmd = { 'clangd', '--background-index', '--log=error' }, }

-- tex
lspconfig.texlab.setup {}

-- lua
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', },
      diagnostics = {
	-- Get the language server to recognize the `vim` global
	globals = {'vim'},
      },
      workspace = {
	-- Make the server aware of Neovim runtime files
	library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = { enable = false, },
    },
  },
}

-- rust-analyzer
lspconfig.rust_analyzer.setup {
  settings = {
    ['rust-analyzer'] = {
      diagnostics = { enable = true; }
    }
  }
}

-- disable extra syntax highlighting
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

-- bash
require'lspconfig'.bashls.setup{}
