local config = function()
	require('fzf-lua').setup {
		defaults = {
			git_icons = false,
			buffers_icons = false,
			file_icons = false,
		},
		winopts = {
			border = 'single',
			height = 0.7,
			width = 0.7,
			preview = { hidden = 'hidden', }
		},
		hls = {
			border = "LinrNr",
		},
		keymap = {
			builtin = {
				["<c-e>"] = "preview-page-down",
				["<c-y>"] = "preview-page-up",
			},
			fzf = {
				['alt-a'] = 'toggle-all',
			},
		},
		fzf_colors = {
			['fg'] = { 'fg', 'CursorLine' },
			['bg'] = { 'bg', 'Normal' },
			['hl'] = { 'fg', 'Comment' },
			['fg+'] = { 'fg', 'Normal' },
			['bg+'] = { 'bg', 'CursorLine' },
			['hl+'] = { 'fg', 'Statement' },
			['info'] = { 'fg', 'PreProc' },
			['prompt'] = { 'fg', 'Conditional' },
			['pointer'] = { 'fg', 'Exception' },
			['marker'] = { 'fg', 'Keyword' },
			['spinner'] = { 'fg', 'Label' },
			['header'] = { 'fg', 'Comment' },
			['gutter'] = { 'bg', 'Normal' },
		},
		-- provider setup
		files = {
			prompt = 'Files> ',
			path_shorten = false,
			cwd_prompt = false,
			-- cwd_prompt_shorten_len = 120,
			multiprocess = true,
		},
		lsp = {
			git_icons = false,
			jump_to_single_result = true,
			sync = true,
			async_or_timeout = 5000,
			cwd_only = false,
			severity = 'hint',
		},
		helptags = { previewer = { _ctor = false } },
		manpages = { previewer = { _ctor = false } },
	}

	local function find_files_in()
		vim.ui.input({ prompt = 'Files in: ', completion = "dir" }, function(input)
			if input ~= nil and input ~= '' then
				require('fzf-lua').files({ cwd = input })
			end
		end)
	end

	local function grep_in()
		vim.ui.input({ prompt = 'Grep in: ', completion = "dir" }, function(input)
			if input ~= nil and input ~= '' then
				require('fzf-lua').live_grep({ cwd = input })
			end
		end)
	end

	local map = vim.keymap.set
	map('n', '<leader>f', '<cmd>FzfLua files<cr>', { desc = "FzfLua files" })
	-- map('n', '<leader>if', '<cmd>FzfLua files --cwd=', { desc = "FzfLua find files in" })
	map('n', '<leader>cf', function() find_files_in() end, { desc = "FzfLua find files in cwd" })
	map('n', '<leader>b', '<cmd>FzfLua buffers<cr>', { desc = "FzfLua buffers" })
	map('n', '<leader>r', '<cmd>FzfLua live_grep<cr>', { desc = "FzfLua live_grep" })
	map('n', '<leader>o', '<cmd>FzfLua oldfiles<cr>', { desc = "FzfLua oldfiles" })
	map('n', '<leader>l', '<cmd>FzfLua lines<cr>', { desc = "FzfLua lines" })
	map('n', '<leader>ir', function() grep_in() end, { desc = "FzfLua grep in" })
	map('n', '<leader>A', '<cmd>FzfLua builtin<cr>', { desc = "FzfLua builtin" })
	map('n', '<leader>j', '<cmd>FzfLua jumps<cr>', { desc = "FzfLua jumps" })
	map('n', '<leader>h', '<cmd>FzfLua help_tags<cr>', { desc = "FzfLua help_tags" })
	map('n', '<leader>k', '<cmd>FzfLua keymaps<cr>', { desc = "FzfLua keymaps" })
end

return {
	{
		'ibhagwan/fzf-lua',
		config = config,
		enabled = false,
	}
}
