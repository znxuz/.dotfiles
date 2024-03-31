local map = require('config.mapper').map
local lspc = require('lspconfig')

vim.cmd 'set shortmess+=c'
vim.cmd 'set signcolumn=yes'

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(_)
    map('n', 'gd', '<cmd>FzfLua lsp_definitions<cr>', { buffer = true })
    map('n', 'gD', '<cmd>FzfLua lsp_typedefs<cr>' , { buffer = true })
    map('n', 'gr', '<cmd>FzfLua lsp_references<cr>', { buffer = true })
    map('n', 'gI', '<cmd>FzfLua lsp_implementations<cr>', { buffer = true })
    map('n', '<leader>aa', '<cmd>FzfLua lsp_code_actions<cr>', { buffer = true })
    map('n', '<leader>s', '<cmd>FzfLua lsp_document_symbols<cr>', { buffer = true })
    map('n', '<leader>S', '<cmd>FzfLua lsp_workspace_symbols<cr>', { buffer = true })
    map('n', '<leader>e', '<cmd>FzfLua diagnostics_document<cr>', { buffer = true })
    map('n', '<leader>E', '<cmd>FzfLua diagnostics_workspace<cr>', { buffer = true })
    map('n', '<leader>ce', function () vim.diagnostic.open_float() end, { buffer = true })
    map('n', '[e', function () vim.diagnostic.goto_prev() end, { buffer = true })
    map('n', ']e', function () vim.diagnostic.goto_next() end, { buffer = true })
    map('n', '<leader>ai', function () vim.lsp.inlay_hint(0) end, { buffer = true })
    map('n', '<leader>ar', function () vim.lsp.buf.rename() end, { buffer = true })
    map('n', 'gh', function () vim.lsp.buf.hover() end, { buffer = true })
    map('i', '<c-h>', function () vim.lsp.buf.signature_help() end, { buffer = true })
  end,
})

-- clangd
lspc.clangd.setup {
  cmd = { 'clangd', '--background-index', '--log=error', '--query-driver=/usr/bin/arm-none-eabi-gcc' },
  capabilities = {
    textDocument = { completion = { completionItem = { snippetSupport = false } } },
  },
}
map('n', '<leader><c-^>', '<cmd>ClangdSwitchSourceHeader<cr>')

-- tex
lspc.texlab.setup {}

-- lua
lspc.lua_ls.setup {
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
lspc.rust_analyzer.setup {
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

local M = {}

function M.StatuslineDiagCountAll()
  local cur = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = cur })
  if #clients == 0 then return "" end

  local warn = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  local err = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  if warn ~= 0 or err ~= 0 then
    return string.format("  | ⚠️ %d ❌%d", warn, err)
  end

  return ""
end

return M
