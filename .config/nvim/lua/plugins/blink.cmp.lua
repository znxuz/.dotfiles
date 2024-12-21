return {
	'saghen/blink.cmp',
	dependencies = 'rafamadriz/friendly-snippets',
	lazy = false,
	version = 'v0.*', -- 'v0.8.0'
	opts = {
		keymap = {
			-- case sensitive!!
			['<Tab>'] = { 'select_next', 'fallback' },
			['<S-Tab>'] = { 'select_prev', 'fallback' },
			['<C-n>'] = { 'select_next', 'fallback' }, -- add snippet forward after blink#289
			['<C-p>'] = { 'select_prev', 'fallback' }, -- add snippet backward
			['<C-y>'] = { 'accept', 'fallback' },
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
				draw = { columns = { { 'label', 'label_description', gap = 1 }, { 'kind' } } },
			},
		},
		sources = {
			cmdline = {}, -- disable cmdline completions
		},
	},
	enabled = true,
}
