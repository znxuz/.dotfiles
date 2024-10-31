local config = function()
	local telescope = require('telescope')
	local builtin = require('telescope.builtin')
	local actions = require('telescope.actions')
	local actions_layout = require('telescope.actions.layout')

	local lsp_symbols_config = {
		fname_width = 50,
		symbol_width = 40,
	}

	telescope.setup {
		defaults = {
			layout_strategy = 'vertical',
			layout_config = {
				width = 0.6,
				height = 0.8,
				preview_cutoff = 30
			},
			borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
			preview = {
				hide_on_startup = false,
				treesitter = false,
			},
			mappings = {
				i = {
					["<esc>"] = actions.close,
					["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					["<c-s>"] = actions.select_horizontal,
					["<c-f>"] = actions_layout.toggle_preview,
				},
			},
			file_ignore_patterns = { ".git", ".cache", "build" },
		},
		pickers = {
			find_files = {
				hidden = true,
				no_ignore = false,
			},
			buffers = {
				sort_mru = true,
				ignore_current_buffer = true,
			},
			lsp_document_symbols = lsp_symbols_config,
			lsp_workspace_symbols = lsp_symbols_config,
		},
		extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			}
		}
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
	map('n', '<leader>f', function() builtin.find_files() end)
	map('n', '<leader>cf', function() builtin.find_files({ cwd = vim.fn.expand('%:h') }) end)
	map('n', '<leader>if', function()
		prompt_cwd_callback({ prompt = 'Files in: ', callback = builtin.find_files })
	end)
	map('n', '<leader>b', function() builtin.buffers() end)
	map('n', '<leader>r', function() builtin.grep_string({ search = "" }) end)
	map({ 'n', 'v' }, '<leader>cr', function() builtin.grep_string() end)
	map('n', '<leader>R', function() builtin.live_grep() end)
	map('n', '<leader>iR', function()
		prompt_cwd_callback({ prompt = 'Live grep in: ', callback = builtin.live_grep })
	end)
	map('n', '<leader>h', function() builtin.help_tags() end)
	map('n', '<leader>j', function() builtin.jumplist() end)
	map('n', '<leader>k', function() builtin.keymaps() end)
	map('n', '<leader>t', function() builtin.builtin() end)

	vim.api.nvim_create_augroup('LspMapping', { clear = false })
	vim.api.nvim_create_autocmd('LspAttach', {
		group = 'LspMapping',
		callback = function(_)
			map('n', 'grr', function() builtin.lsp_references() end, { buffer = true })
			map('n', 'gI', function() builtin.lsp_implementations() end, { buffer = true })
			map('n', '<leader>s', function() builtin.lsp_document_symbols() end, { buffer = true })
			map('n', '<leader>S', function() builtin.lsp_workspace_symbols() end, { buffer = true })
			map('n', '<leader>d', function() builtin.diagnostics({ bufnr = 0 }) end, { buffer = true })
			map('n', '<leader>D', function() builtin.diagnostics() end, { buffer = true })
		end,
	})
end

return {
	{
		'nvim-telescope/telescope.nvim',
		dependencies = 'nvim-lua/plenary.nvim',
		config = config,
	},
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make'
	},
}
