return {
	'neovim/nvim-lspconfig',
	config = function()
		local lspcfg = require('lspconfig')

		vim.opt.shortmess:append('c')
		vim.opt.signcolumn = 'yes'

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("LspAttachAug", { clear = false }),
			callback = function(_)
				vim.keymap.set('n', 'gd', function() vim.lsp.buf.type_definition() end, { buffer = true, desc = "Go To Type Definition" })
				vim.keymap.set('n', 'grh', function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
				end, { buffer = true, desc = "Toggle Inlay Hint" })
				vim.keymap.set('n', 'grd', function() vim.diagnostic.setqflist() end)
			end,
		})

		local on_init = function(client, _)
			client.server_capabilities.semanticTokensProvider = nil -- turn off semantic tokens
		end

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

		lspcfg.bashls.setup {
			on_init = on_init,
		}

		lspcfg.pylsp.setup {
			on_init = on_init,
		}
	end
}
