local map = require('config.mapper').map
local lspc = require('lspconfig')

vim.cmd 'set shortmess+=c'
vim.cmd 'set signcolumn=yes'

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(_)
		map('n', '<leader>ce', function () vim.diagnostic.open_float() end, { buffer = true })
		map('n', '[e', function () vim.diagnostic.goto_prev() end, { buffer = true })
		map('n', ']e', function () vim.diagnostic.goto_next() end, { buffer = true })
		map('n', '<leader>ai', function ()
			vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
		end, { buffer = true })
		map('n', '<leader>ar', function () vim.lsp.buf.rename() end, { buffer = true })
		map('n', 'gh', function () vim.lsp.buf.hover() end, { buffer = true })
		map('i', '<c-h>', function () vim.lsp.buf.signature_help() end, { buffer = true })
	end,
})

-- clangd
lspc.clangd.setup {
	cmd = { 'clangd', '--background-index', '--log=error', '--query-driver=/usr/bin/arm-none-eabi-gcc,/usr/bin/arm-none-eabi-g++' },
	capabilities = {
		textDocument = { completion = { completionItem = { snippetSupport = false } } },
	},
}

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
		vim.lsp.get_client_by_id(args.data.client_id).server_capabilities.semanticTokensProvider = nil
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
