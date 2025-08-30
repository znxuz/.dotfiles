vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LspAttachAug", { clear = false }),
	callback = function ()
		vim.keymap.set('n', 'gd', vim.lsp.buf.type_definition,
			{ buffer = true, desc = "Go To Type Definition" })
		vim.keymap.set('n', 'grh', function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
		end, { buffer = true, desc = "Toggle Inlay Hint" })
		vim.keymap.set('n', 'grd', vim.diagnostic.setqflist)

		vim.diagnostic.config({ virtual_text = { current_line = true } })

		vim.api.nvim_create_user_command('LspStop', function()
			vim.lsp.stop_client(vim.lsp.get_clients())
		end, {})

		vim.api.nvim_create_user_command('LspLog', function()
			vim.cmd('tabe ' .. vim.fn.stdpath("log") .. '/lsp.log')
		end, {})

		vim.api.nvim_create_user_command('LspFmt', function() vim.lsp.buf.format() end, {})
	end,
})

vim.opt.shortmess:append('c')
vim.opt.signcolumn = 'yes'

vim.lsp.config('*', {
	on_init = function(client, _)
		client.server_capabilities.semanticTokensProvider = nil -- turn off semantic tokens
	end,
	capabilities = {
		textDocument = {
			semanticTokens = { multilineTokenSupport = true },
			completion = { completionItem = { snippetSupport = false } }
		}
	},
	root_markers = { '.git' },
})

vim.lsp.enable({
	'clangd',
	'texlab',
	'luals',
	'rust_analyzer',
	'bashls',
	'pylsp',
})
