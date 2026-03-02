vim.opt.shortmess:append('c')
vim.opt.signcolumn = 'yes'

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach", {}),
	callback = function()
		vim.diagnostic.config({ virtual_text = { current_line = true } })

		vim.keymap.set('n', 'grh', function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
		end, { buffer = true })
		vim.keymap.set('n', 'grd', vim.diagnostic.setqflist, { buffer = true })
		vim.keymap.set('n', 'gO', function()
			vim.lsp.buf.document_symbol({
				on_list = function(opts)
					local cur_line = vim.api.nvim_win_get_cursor(0)[1]
					local best_match_idx = 1
					for i, item in ipairs(opts.items) do
						if item.lnum > cur_line then break end
						best_match_idx = i
					end
					vim.fn.setloclist(0, {}, ' ', {
						title = opts.title,
						items = opts.items,
						idx = best_match_idx,
						quickfixtextfunc = function(dict)
							local lines = {}
							for i = dict.start_idx, dict.end_idx do
								table.insert(lines, opts.items[i].text)
							end
							return lines
						end
					})
					vim.cmd.lw()
				end,
			})
		end, { buffer = true })
		vim.keymap.set('n', 'grr', function()
			vim.lsp.buf.references(nil, {
				on_list = function(opts)
					local cur_line = vim.api.nvim_win_get_cursor(0)[1]
					local match_idx = 1
					for i, item in ipairs(opts.items) do
						if item.lnum == cur_line and
								item.filename == vim.api.nvim_buf_get_name(opts.context.bufnr) then
							match_idx = i
							break
						end
					end
					vim.fn.setqflist({}, ' ', {
						title = opts.title,
						items = opts.items,
						idx = match_idx,
					})
					vim.cmd.cw()
				end,
			})
		end, { buffer = true })
	end
})

vim.lsp.config('*', {
	on_init = function(client, _)
		client.server_capabilities.semanticTokensProvider = nil -- turn off lsp highlight for semantic tokens
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
