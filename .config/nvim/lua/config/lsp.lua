local map = require('config.mapper').map
local lspc = require('lspconfig')

vim.opt.shortmess:append('c')
vim.opt.signcolumn = 'yes'

vim.api.nvim_create_augroup("LspMapping", { clear = false })
vim.api.nvim_create_autocmd("LspAttach", {
	group = "LspMapping",
	callback = function(_)
		map('n', '<leader>ai', function ()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
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
	group = "LspMapping",
	callback = function(args)
		vim.lsp.get_client_by_id(args.data.client_id).server_capabilities.semanticTokensProvider = nil
	end,
})

-- bash
require'lspconfig'.bashls.setup{}

-- python
require'lspconfig'.pylsp.setup{}
