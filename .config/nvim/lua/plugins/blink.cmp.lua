return {
	'saghen/blink.cmp',
	dependencies = 'rafamadriz/friendly-snippets',
	lazy = false,

	version = 'v0.*',
	opts = {
		keymap = {
			-- case sensitive!!
			['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
			['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
			['<C-y>'] = { 'select_and_accept', 'fallback' },
			['<C-l>'] = { 'show', 'hide', 'fallback' },
			['<C-_>'] = { 'cancel', 'fallback' },
			['<C-Space>'] = { 'show_documentation', 'hide_documentation', 'fallback' },
			['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
			['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
		},

		completion = {
			list = { selection = 'auto_insert' },
			accept = { auto_brackets = { enabled = false } },
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 0,
			},
			menu = {
				border = 'none',
				draw = { columns = { { 'label', 'label_description', gap = 1 }, { 'kind' } } },
			},
		},
	},
}
