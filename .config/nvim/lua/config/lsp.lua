-- [[
-- language server configuration command: lspconfig -all
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- ]]

local map = require('config.utils').map
local lspconfig = require('lspconfig')

vim.cmd 'set shortmess+=c'
vim.cmd 'set signcolumn=yes'

map('n', 'gd', '<cmd>FzfLua lsp_definitions<cr>')
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
map('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<cr>')
map('n', 'gr', '<cmd>FzfLua lsp_references<cr>')
map('i', '<c-h>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
map('n', '<leader>d', '<cmd>FzfLua lsp_typedefs<cr>')
map('n', '<leader>aa', '<cmd>FzfLua lsp_code_actions<cr>')
map('n', '<leader>ar', '<cmd>lua vim.lsp.buf.rename()<cr>')
map('n', '<leader>s', '<cmd>FzfLua lsp_document_symbols<cr>')
map('n', '<leader>S', '<cmd>FzfLua lsp_live_workspace_symbols<cr>')
map('n', '<leader>E', '<cmd>FzfLua lsp_workspace_diagnostics<cr>')
map('n', '<leader>e', '<cmd>FzfLua lsp_document_diagnostics<cr>')
map('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
map('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<cr>')
map('n', '<leader>ce', '<cmd>lua vim.diagnostic.open_float()<cr>')
map('n', '<leader>ai', '<cmd>lua vim.lsp.inlay_hint(0)<cr>')

-- clangd
lspconfig.clangd.setup { cmd = { 'clangd', '--background-index', '--log=error' } }
map('n', '<leader><c-^>', '<cmd>ClangdSwitchSourceHeader<cr>')

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
  settings = { ['rust-analyzer'] = { diagnostics = { enable = true; } } }
}
