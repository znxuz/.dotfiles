local config = function()
	local map = vim.keymap.set
	local lspcfg = require('lspconfig')

	vim.opt.shortmess:append('c')
	vim.opt.signcolumn = 'yes'

	vim.api.nvim_create_augroup("LspMapping", { clear = false })
	vim.api.nvim_create_autocmd("LspAttach", {
		group = "LspMapping",
		callback = function(_)
			map('n', 'gd', function() vim.lsp.buf.definition() end, { buffer = true })
			map('n', 'gD', function() vim.lsp.buf.type_definition() end, { buffer = true })
			map('n', 'gri', function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
			end, { buffer = true })
		end,
	})

	lspcfg.clangd.setup {
		cmd = {
			'clangd',
			'--background-index',
			'--log=error',
			'--query-driver=/usr/bin/arm-none-eabi-gcc,/usr/bin/arm-none-eabi-g++'
		},
		capabilities = {
			textDocument = { completion = { completionItem = { snippetSupport = false } } },
		},
	}
	lspcfg.texlab.setup {}

	lspcfg.lua_ls.setup {
		settings = {
			Lua = {
				runtime = { version = 'LuaJIT', },
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { 'vim' },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = { enable = false, },
			},
		},
	}

	lspcfg.rust_analyzer.setup {
		settings = {
			['rust-analyzer'] = {
				completion = {
					callable = { snippets = "none" }
				}
			}
		}
	}

	-- bash
	lspcfg.bashls.setup {}

	-- python
	lspcfg.pylsp.setup {}

	--dart
	lspcfg.dartls.setup {}

	-- disable extra syntax highlighting
	vim.api.nvim_create_autocmd("LspAttach", {
		group = "LspMapping",
		callback = function(args)
			vim.lsp.get_client_by_id(args.data.client_id).server_capabilities.semanticTokensProvider = nil
		end,
	})
end

return {
	{
		'neovim/nvim-lspconfig',
		config = config
	},
}
