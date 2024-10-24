return {
	'saghen/blink.cmp',
	lazy = false, -- lazy loading handled internally
	-- optional: provides snippets for the snippet source

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			show = '<c-l>',
			hide = '<c-h>',
			accept = { '<Tab>', '<c-y>' },
			select_prev = { '<Up>', '<c-p>' },
			select_next = { '<Down>', '<c-n>' },

			show_documentation = '<m-space>',
			hide_documentation = '<m-space>',
			scroll_documentation_up = '<c-y>',
			scroll_documentation_down = '<c-e>',

			snippet_forward = '<c-j>',
			snippet_backward = '<c-k>',
		},
		fuzzy = {
			use_frecency = true,
			use_proximity = true,
			max_items = 100,
			sorts = { 'label', 'score', 'kind', },
		},
		sources = {
			completion = {
				enabled_providers = { 'lsp', 'path', 'buffer' },
			},
		},
		windows = {
			autocomplete = {
				scrolloff = 2,
				-- which directions to show the window,
				-- falling back to the next direction when there's not enough space
				direction_priority = { 's', 'n' },
				selection = 'preselect',
				draw = 'minimal',
				cycle = {
					from_bottom = true,
					from_top = true,
				},
			},
		},
		documentation = {
			border = 'padded',
			-- which directions to show the documentation window,
			-- for each of the possible autocomplete window directions,
			-- falling back to the next direction when there's not enough space
			direction_priority = {
				autocomplete_north = { 'e', 'w', 'n', 's' },
				autocomplete_south = { 'e', 'w', 's', 'n' },
			},
			auto_show = true,
			auto_show_delay_ms = 200,
			update_delay_ms = 50,
		},
	},
	enabled = false,
}
