return {
	'saghen/blink.cmp',
	dependencies = 'rafamadriz/friendly-snippets',
	event = 'InsertEnter',
	version = '1.*',
	opts = {
		keymap = {
			preset = 'none',
			-- case sensitive!!
			['<Tab>'] = { 'select_next', 'fallback' },
			['<S-Tab>'] = { 'select_prev', 'fallback' },
			['<C-n>'] = { 'snippet_forward', 'select_next', 'fallback' },
			['<C-p>'] = { 'snippet_backward', 'select_prev', 'fallback' },
			['<C-y>'] = { 'accept', 'fallback' },
			['<C-l>'] = { 'show', 'hide', 'fallback' },
			['<C-_>'] = { 'cancel', 'fallback' },
			['<C-Space>'] = { 'show_documentation', 'hide_documentation', 'fallback' },
			['<A-j>'] = { 'scroll_documentation_down', 'fallback' },
			['<A-k>'] = { 'scroll_documentation_up', 'fallback' },
			['<C-d>'] = {
				function(cmp)
					if vim.fn.mode() == 's' and cmp.snippet_active({ direction = 1 }) then
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-g>"_c', true, false, true), 'n', false)
						vim.schedule(function()
							cmp.snippet_forward()
						end)
						return true
					end
				end,
				'fallback',
			},
		},
		completion = {
			-- trigger = { show_in_snippet = false },
			list = {
				selection = {
					preselect = true,
					auto_insert = true
				}
			},
			accept = { auto_brackets = { enabled = false } },
			menu = {
				max_height = vim.o.pumheight,
				draw = { columns = { { 'label', 'label_description' }, { 'kind' } }, }
			},
			documentation = {
				auto_show = false,
				auto_show_delay_ms = 0,
			}
		},
		sources = {
			default = { "snippets", "lsp", "buffer" },
			providers = {
				snippets = {
					score_offset = 2,
					opts = {
						get_filetype = function(_)
							return vim.bo.filetype == 'vimwiki' and 'markdown' or vim.bo.filetype
						end
					}
				},
				lsp = { score_offset = 1 },
				buffer = { score_offset = 0 },
			},
		},
		cmdline = { enabled = false },
	},
}
