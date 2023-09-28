local map = require('config.utils').map
local lspconfig = require('lspconfig')
local ls = require 'luasnip'

vim.cmd 'set shortmess+=c'
vim.cmd 'set signcolumn=yes'

-- lsp mappings
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(_)
    map('n', 'gd', function () vim.lsp.buf.definition() end, { buffer = true })
    map('n', 'gD', function () vim.lsp.buf.type_definition() end, { buffer = true })
    map('n', 'gh', function () vim.lsp.buf.hover() end, { buffer = true })
    map('n', 'gr', function () vim.lsp.buf.references() end, { buffer = true })
    map('i', '<c-h>', function () vim.lsp.buf.signature_help() end, { buffer = true })
    map('n', '<leader>aa', function () vim.lsp.buf.code_action() end, { buffer = true })
    map('n', '<leader>ar', function () vim.lsp.buf.rename() end, { buffer = true })
    map('n', '<leader>s', '<cmd>FzfLua lsp_document_symbols<cr>', { buffer = true })
    map('n', '<leader>S', '<cmd>FzfLua lsp_live_workspace_symbols<cr>', { buffer = true })
    map('n', '<leader>E', '<cmd>FzfLua lsp_workspace_diagnostics<cr>', { buffer = true })
    map('n', '<leader>e', '<cmd>FzfLua lsp_document_diagnostics<cr>', { buffer = true })
    map('n', '[e', function () vim.diagnostic.goto_prev() end, { buffer = true })
    map('n', ']e', function () vim.diagnostic.goto_next() end, { buffer = true })
    map('n', '<leader>ce', function () vim.diagnostic.open_float() end, { buffer = true })
    map('n', '<leader>ai', function () vim.lsp.inlay_hint(0) end, { buffer = true })

    map('n', '<leader><c-^>', '<cmd>ClangdSwitchSourceHeader<cr>')

    map({"i", "s"}, "<c-j>", function() ls.jump(1) end, {silent = true})
    map({"i", "s"}, "<c-k>", function() ls.jump(-1) end, {silent = true})
  end,
})

-- clangd
lspconfig.clangd.setup {
  cmd = { 'clangd', '--background-index', '--log=error' },
  capabilities = {
    textDocument = {
      completion = {
	completionItem = {
	  snippetSupport = false,
	},
      },
    },
  },
}

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

-- python
require'lspconfig'.pylsp.setup{}
