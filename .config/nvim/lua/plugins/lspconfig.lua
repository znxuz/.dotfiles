local config = function()
	local lspcfg = require('lspconfig')
	local map = vim.keymap.set

	local on_init = function(client, _)
		client.server_capabilities.semanticTokensProvider = nil -- turn off semantic tokens
	end

	vim.opt.shortmess:append('c')
	vim.opt.signcolumn = 'yes'

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("LspAttachAug", { clear = false }),
		callback = function(_)
			map('n', 'gd', function() vim.lsp.buf.type_definition() end, { buffer = true, desc = "Go To Type Definition" })
			map('n', 'grh', function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
			end, { buffer = true, desc = "Toggle Inlay Hint" })
		end,
	})

	lspcfg.clangd.setup {
		on_init = on_init,
		cmd = {
			'clangd',
			'--background-index',
			'--log=error',
			'--query-driver=/usr/bin/arm-none-eabi-gcc,/usr/bin/arm-none-eabi-g++'
		},
		capabilities = {
			textDocument = {
				completion = { completionItem = { snippetSupport = false } }
			},
		},
	}

	lspcfg.texlab.setup {
		on_init = on_init,
	}

	lspcfg.lua_ls.setup {
		on_init = on_init,
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
		on_init = on_init,
		settings = {
			['rust-analyzer'] = {
				completion = {
					callable = { snippets = "none" }
				}
			}
		}
	}

	-- bash
	lspcfg.bashls.setup {
		on_init = on_init,
	}

	-- python
	lspcfg.pylsp.setup {
		on_init = on_init,
	}

	--dart
	lspcfg.dartls.setup {
		on_init = on_init,
	}
end

return {
	{
		'neovim/nvim-lspconfig',
		config = config
	},
}
