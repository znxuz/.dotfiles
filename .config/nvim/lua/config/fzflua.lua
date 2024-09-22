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

local M = {}

M.find_files_in = function()
	vim.ui.input({ prompt = 'Files in: ', completion = "dir" }, function(input)
		if input ~= nil and input ~= '' then
			require('fzf-lua').files({ cwd = input })
		end
	end)
end

M.grep_in = function()
	vim.ui.input({ prompt = 'Grep in: ', completion = "dir" }, function(input)
		if input ~= nil and input ~= '' then
			require('fzf-lua').live_grep({ cwd = input })
		end
	end)
end

local map = require('config.mapper').map
map('n', '<leader>f', '<cmd>FzfLua files<cr>')
map('n', '<leader>cf', function() require('fzf-lua').files({ cwd = vim.fn.expand('%:h') }) end)
map('n', '<leader>if', function() require("config.fzflua").find_files_in() end)
map('n', '<leader>b', '<cmd>FzfLua buffers<cr>')
map('n', '<leader>r', '<cmd>FzfLua live_grep<cr>')
map('n', '<leader>o', '<cmd>FzfLua oldfiles<cr>')
map('n', '<leader>l', '<cmd>FzfLua lines<cr>')
map('n', '<leader>ir', function() require("config.fzflua").grep_in() end)
map('n', '<leader>A', '<cmd>FzfLua builtin<cr>')
map('n', '<leader>j', '<cmd>FzfLua jumps<cr>')
map('n', '<leader>h', '<cmd>FzfLua help_tags<cr>')
map('n', '<leader>k', '<cmd>FzfLua keymaps<cr>')

return M
