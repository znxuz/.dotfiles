return {
	'nvim-telescope/telescope.nvim',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make'
		},
	},
	config = function()
		local telescope = require('telescope')
		local builtin = require('telescope.builtin')
		local actions = require('telescope.actions')
		local actions_layout = require('telescope.actions.layout')

		-- local lsp_symbols_config = {
		-- 	fname_width = 50,
		-- 	symbol_width = 40,
		-- }

		telescope.setup {
			defaults = require('telescope.themes').get_ivy({
				layout_config = { height = 0.3 },
				preview = { treesitter = false },
				dynamic_preview_title = true,
				mappings = {
					i = {
						["<esc>"] = actions.close,
						["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						["<c-s>"] = actions.select_horizontal,
						["<c-f>"] = actions_layout.toggle_preview,
					},
				},
				file_ignore_patterns = { ".git", ".cache", "build" },
				color_devicons = false,
			}),
			pickers = {
				find_files = {
					hidden = true,
					no_ignore = false,
				},
				buffers = {
					sort_mru = true,
					ignore_current_buffer = true,
				},
				-- lsp_document_symbols = lsp_symbols_config,
				-- lsp_workspace_symbols = lsp_symbols_config,
			},
		}
		telescope.load_extension('fzf')

		local function prompt_cwd_callback(args)
			vim.ui.input({ prompt = args.prompt, completion = 'dir' }, function(input)
				if input == nil or input == '' then
					return
				elseif vim.fn.isdirectory(vim.fn.fnamemodify(input, ':p')) == 0 then
					vim.api.nvim_command('redraw')
					vim.api.nvim_err_writeln('Input is not a directory')
					return
				end

				args.callback({ cwd = input })
			end)
		end

		local map = vim.keymap.set
		map('n', '<leader>s', function() builtin.find_files() end, { desc = 'Telescope Find files' })
		map('n', '<leader>cs', function() builtin.find_files({ cwd = vim.fn.expand('%:h') }) end,
			{ desc = 'Telescope Find files in current directory' })
		map('n', '<leader>is', function()
			prompt_cwd_callback({ prompt = 'Files in: ', callback = builtin.find_files })
		end, { desc = 'Telescope Interactive file search' })
		map('n', '<leader>b', function() builtin.buffers() end, { desc = 'Telescope List open buffers' })
		map('n', '<leader>r', function() builtin.grep_string({ search = "" }) end,
			{ desc = 'Telescope Grep for string under cursor' })
		map({ 'n', 'v' }, '<leader>cr', function() builtin.grep_string() end, { desc = 'Telescope Grep for selected text' })
		map('n', '<leader>R', function() builtin.live_grep() end, { desc = 'Telescope Live grep' })
		map('n', '<leader>iR', function()
			prompt_cwd_callback({ prompt = 'Live grep in: ', callback = builtin.live_grep })
		end, { desc = 'Telescope Interactive live grep' })
		map('n', '<leader>h', function() builtin.help_tags() end, { desc = 'Telescope Show help tags' })
		map('n', '<leader>j', function() builtin.jumplist() end, { desc = 'Telescope Show jumplist' })
		map('n', '<leader>k', function() builtin.keymaps() end, { desc = 'Telescope Show key mappings' })
		map('n', '<leader>t', function() builtin.builtin() end, { desc = 'Telescope Show available built-in commands' })
	end
}
