local function prompt_cwd_callback(args)
	vim.ui.input({ prompt = args.prompt, completion = 'dir' }, function(input)
		if input == nil or input == '' then
			return
		elseif vim.fn.isdirectory(vim.fn.fnamemodify(input, ':p')) == 0 then
			vim.api.nvim_command('redraw')
			vim.api.nvim_echo({ { 'Input is not a directory' } }, true, { err = true })
			return
		end

		args.callback({ cwd = input })
	end)
end

return {
	'nvim-telescope/telescope.nvim',
	enabled = true,
	lazy = true,
	dependencies = {
		'nvim-lua/plenary.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make'
		},
	},
	config = function()
		local telescope = require('telescope')
		local actions = require('telescope.actions')
		local actions_layout = require('telescope.actions.layout')

		telescope.setup {
			defaults = require('telescope.themes').get_ivy({
				layout_config = {
					preview_cutoff = 60,
					height = 0.2
				},
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
			},
		}
		telescope.load_extension('fzf')
	end,

	keys = {
		{ '<leader>s', function() require('telescope.builtin').find_files() end, { desc = 'Telescope Find files' },        'n' },
		{ '<leader>cs', function() require('telescope.builtin').find_files({ cwd = vim.fn.expand('%:h') }) end,
			{ desc = 'Telescope Find files in current directory' }, 'n', },
		{ '<leader>is', function()
			prompt_cwd_callback({ prompt = 'Files in: ', callback = require('telescope.builtin').find_files })
		end, { desc = 'Telescope Interactive file search' }, 'n', },
		{ '<leader>b', function() require('telescope.builtin').buffers() end,    { desc = 'Telescope List open buffers' }, 'n', },
		{ '<leader>r', function() require('telescope.builtin').grep_string({ search = "" }) end,
			{ desc = 'Telescope Grep for string under cursor' }, 'n', },
		{ '<leader>cr', function() require('telescope.builtin').grep_string() end, { desc = 'Telescope Grep for selected text' }, { 'n', 'v' }, },
		{ '<leader>R',  function() require('telescope.builtin').live_grep() end,   { desc = 'Telescope Live grep' },              'n', },
		{ '<leader>iR', function()
			prompt_cwd_callback({ prompt = 'Live grep in: ', callback = require('telescope.builtin').live_grep })
		end, { desc = 'Telescope Interactive live grep' }, 'n', },
		{ '<leader>h', function() require('telescope.builtin').help_tags() end, { desc = 'Telescope Show help tags' },                   'n', },
		{ '<leader>j', function() require('telescope.builtin').jumplist() end,  { desc = 'Telescope Show jumplist' },                    'n', },
		{ '<leader>k', function() require('telescope.builtin').keymaps() end,   { desc = 'Telescope Show key mappings' },                'n', },
		{ '<leader>t', function() require('telescope.builtin').builtin() end,   { desc = 'Telescope Show available built-in commands' }, 'n', },
	}
}
