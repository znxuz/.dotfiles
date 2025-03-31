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
					preview_cutoff = 0,
					height = 11
				},
				preview = {
					hide_on_startup = true,
					treesitter = false
				},
				dynamic_preview_title = true,
				mappings = {
					i = {
						["<esc>"] = actions.close,
						["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						["<c-s>"] = actions.select_horizontal,
						["<c-space>"] = actions_layout.toggle_preview,
					},
				},
				file_ignore_patterns = { ".git", ".cache", "build" },
				color_devicons = false,
			}),
			pickers = {
				find_files = { hidden = true },
				buffers = {
					sort_mru = true,
					ignore_current_buffer = true,
				},
			},
		}
		telescope.load_extension('fzf')

		vim.api.nvim_set_hl(0, "TelescopeTitle", { bg = "none" })
	end,
	keys = {
		{ '<leader>s', function() require('telescope.builtin').find_files() end, { desc = 'Telescope Find files' } },
		{ '<leader>cs', function() require('telescope.builtin').find_files({ cwd = vim.fn.expand('%:h') }) end,
			{ desc = 'Telescope Find files relative to the current buffer' } },
		{ '<leader>is', function()
			prompt_cwd_callback({ prompt = 'Files in: ', callback = require('telescope.builtin').find_files })
		end, { desc = 'Telescope Interactive file search' } },
		{ '<leader>b', function() require('telescope.builtin').buffers() end,    { desc = 'Telescope List open buffers' } },
		{ '<leader>r', function() require('telescope.builtin').grep_string({ search = "" }) end,
			{ desc = 'Telescope Grep for string under cursor' } },
		{ '<leader>cr', function() require('telescope.builtin').grep_string() end, { desc = 'Telescope Grep for selected text' }, mode = { 'n', 'v' } },
		{ '<leader>R',  function() require('telescope.builtin').live_grep() end,   { desc = 'Telescope Live grep' } },
		{ '<leader>iR', function()
			prompt_cwd_callback({ prompt = 'Live grep in: ', callback = require('telescope.builtin').live_grep })
		end, { desc = 'Telescope Interactive live grep' } },
		{ '<leader>cR', function() require('telescope.builtin').live_grep({ cwd = vim.fn.expand('%:h') }) end, { desc = 'Telescope Live Grep in current directory' } },
		{ '<leader>h',  function() require('telescope.builtin').help_tags() end,                               { desc = 'Telescope Show help tags' }, },
		{ '<leader>k',  function() require('telescope.builtin').keymaps() end,                                 { desc = 'Telescope Show key mappings' }, },
		{ '<leader>t',  function() require('telescope.builtin').builtin() end,                                 { desc = 'Telescope Show available built-in commands' } },
	}
}
