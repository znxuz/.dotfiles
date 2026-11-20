vim.opt.shortmess:append('c')
vim.opt.signcolumn = 'yes'

local function find_match_idx(opts)
	local bufname = vim.api.nvim_buf_get_name(opts.context.bufnr)
	local idx = 1
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	col = col + 1
	for i, item in ipairs(opts.items) do
		if item.filename ~= bufname then goto continue end
		if item.lnum > line or (item.lnum == line and item.col > col) then break end
		idx = i
		::continue::
	end
	return idx
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach", {}),
	callback = function()
		local function mine_document_symbol(open, callback)
			vim.lsp.buf.document_symbol({
				on_list = function(opts)
					vim.fn.setloclist(0, {}, ' ', {
						title = opts.title,
						items = opts.items,
						idx = find_match_idx(opts),
						quickfixtextfunc = function(dict)
							local lines = {}
							for i = dict.start_idx, dict.end_idx do
								table.insert(lines, opts.items[i].text)
							end
							return lines
						end
					})
					if open then
						vim.cmd.lcl()
						vim.cmd.lw()
					end
					if callback then pcall(callback) end
				end,
			})
		end

		vim.diagnostic.config({ virtual_text = { current_line = true } })

		vim.keymap.set('n', 'grT', function()
			vim.cmd.sp()
			vim.lsp.buf.type_definition()
		end, { buffer = true })
		vim.keymap.set('n', 'grh', function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
		end, { buffer = true })
		vim.keymap.set('n', 'grd', vim.diagnostic.setloclist, { buffer = true })
		vim.keymap.set('n', 'grD', vim.diagnostic.setqflist, { buffer = true })
		vim.keymap.set('n', 'gO', function() mine_document_symbol(true) end, { buffer = true })
		vim.keymap.set('n', '[t', function() mine_document_symbol(false, vim.cmd.lp) end)
		vim.keymap.set('n', ']t', function() mine_document_symbol(false, vim.cmd.lne) end)
		vim.keymap.set('n', 'tt', function() mine_document_symbol(false, vim.cmd.ll) end)
		vim.keymap.set('n', 'grr', function()
			vim.lsp.buf.references(nil, {
				on_list = function(opts)
					vim.fn.setqflist({}, ' ', {
						title = opts.title,
						items = opts.items,
						idx = find_match_idx(opts),
					})
					vim.cmd.ccl()
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
	'pylsp'
})

-- clang-tidy toggle

local clangd_cmd = vim.deepcopy(vim.lsp.config['clangd'].cmd)
local tidy_enabled = false

local function toggle_clang_tidy()
	tidy_enabled = not tidy_enabled

	local new_cmd = vim.tbl_filter(function(arg)
		return not vim.startswith(arg, '--clang-tidy')
	end, clangd_cmd)
	table.insert(new_cmd, tidy_enabled and '--clang-tidy=1' or '--clang-tidy=0')

	vim.lsp.config('clangd', { cmd = new_cmd })

	local clients = vim.lsp.get_clients({ name = 'clangd' })
	if #clients > 0 then
		for _, client in ipairs(clients) do
			client:stop(true)
		end
		vim.defer_fn(function()
			vim.cmd.edit()
		end, 100)
	end

	vim.notify('clang-tidy: ' .. (tidy_enabled and 'ON' or 'OFF'), vim.log.levels.INFO)
end

vim.api.nvim_create_user_command('ClangdToggleTidy', toggle_clang_tidy)
