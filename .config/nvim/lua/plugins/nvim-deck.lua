return {
	'hrsh7th/nvim-deck',
	config = function()
		local deck = require('deck')

		deck.setup({
			default_start_config = {
				view = function()
					return require('deck.builtin.view.default').create({ max_height = 10 })
				end,
			},
		})
		require('deck.easy').setup()

		-- Set up buffer-specific key mappings for nvim-deck.
		vim.api.nvim_create_autocmd('User', {
			pattern = 'DeckStart',
			callback = function(e)
				local ctx = e.data.ctx --[[@as deck.Context]]
				ctx.keymap('n', '<Esc>', function()
					ctx.set_preview_mode(false)
				end)
				ctx.keymap('n', '<Tab>', deck.action_mapping('choose_action'))
				ctx.keymap('n', '<C-l>', deck.action_mapping('refresh'))
				ctx.keymap('n', 'i', deck.action_mapping('prompt'))
				ctx.keymap('n', '@', deck.action_mapping('toggle_select'))
				ctx.keymap('n', '*', deck.action_mapping('toggle_select_all'))
				ctx.keymap('n', 'p', deck.action_mapping('toggle_preview_mode'))
				ctx.keymap('n', '<CR>', deck.action_mapping('open'))
				ctx.keymap('n', 's', deck.action_mapping('open_split'))
				ctx.keymap('n', 'v', deck.action_mapping('open_vsplit'))
				ctx.keymap('n', '<C-b>', deck.action_mapping('scroll_preview_up'))
				ctx.keymap('n', '<C-f>', deck.action_mapping('scroll_preview_down'))

				ctx.prompt()
			end
		})

		vim.keymap.set('n', '<Leader>s', function()
			deck.start(require('deck.builtin.source.files')({
				root_dir     = vim.fn.getcwd(),
				ignore_globs = { '**/.git/' },
			}))
		end, { desc = 'Show recent files, buffers, and more' })
		vim.keymap.set('n', '<Leader>is', function()
			deck.start(require('deck.builtin.source.files')({
				root_dir     = vim.fn.input('directory: ', '', 'dir'),
				ignore_globs = { '**/.git/' },
			}))
		end, { desc = 'Show recent files, buffers, and more given the directory' })
		vim.keymap.set('n', '<Leader>cs', function()
			deck.start(require('deck.builtin.source.files')({
				root_dir     = vim.fn.expand('%:h'),
				ignore_globs = { '**/.git/' },
			}))
		end, { desc = 'Show recent files, buffers, and more from the directory of the current file' })
		vim.keymap.set('n', '<Leader>b', '<Cmd>Deck buffers<CR>', { desc = 'Show buffers' })
		vim.keymap.set('n', '<Leader>r', '<Cmd>Deck grep<CR>', { desc = 'Start grep search' })
		vim.keymap.set('n', '<Leader>R', function()
			deck.start(require('deck.builtin.source.grep')({
				root_dir = vim.fn.getcwd(),
				dynamic = true,
				ignore_globs = { '**/node_modules/', '**/.git/' },
			}))
		end, { desc = 'Start dynamic grep search' })
		vim.keymap.set({ 'n', 'v' }, '<Leader>cr', function()
			deck.start(require('deck.builtin.source.grep')({
				root_dir = vim.fn.getcwd(),
				pattern = vim.fn.expand('<cword>'),
				ignore_globs = { '**/node_modules/', '**/.git/' },
			}))
		end, { desc = 'Start grep search the current word under the cursor' })
		vim.keymap.set('n', '<Leader>h', '<Cmd>Deck helpgrep<CR>', { desc = 'Live grep all help tags' })

		-- Show the latest deck context.
		vim.keymap.set('n', '<Leader>;', function()
			local ctx = require('deck').get_history()[1]
			if ctx then
				ctx.show()
			end
		end)

		-- Do default action on next item.
		-- vim.keymap.set('n', '<Leader>n', function()
		-- 	local ctx = require('deck').get_history()[1]
		-- 	if ctx then
		-- 		ctx.set_cursor(ctx.get_cursor() + 1)
		-- 		ctx.do_action('default')
		-- 	end
		-- end)
	end
}
