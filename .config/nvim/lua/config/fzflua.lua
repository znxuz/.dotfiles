local map = require('config.utils').map
map('n', '<leader>ff', '<cmd>FzfLua files<cr>')
map('n', '<leader>fc', '<cmd>FzfLua files cwd=%:p:h<cr>')
map('n', '<leader>fh', '<cmd>FzfLua files cwd=~<cr>')
map('n', '<leader>fi', '<cmd>lua require("config.fzflua").find_files_in()<cr>')
map('n', '<leader>fb', '<cmd>FzfLua buffers<cr>')
map('n', '<leader>gg', '<cmd>FzfLua live_grep<cr>')
map('n', '<leader>gc', '<cmd>FzfLua live_grep cwd=%:p:h<cr>')
map('n', '<leader>gi', '<cmd>lua require("config.fzflua").grep_in()<cr>')
map('n', '<leader>fa', '<cmd>FzfLua builtin<cr>')
map('n', '<leader>fr', '<cmd>FzfLua resume<cr>')
map('n', '<leader>fq', '<cmd>FzfLua quickfix<cr>')
map('n', '<leader>fj', '<cmd>FzfLua jumps<cr>')
map('n', '<leader>fo', '<cmd>FzfLua oldfiles<cr>')
map('n', '<leader>ft', '<cmd>FzfLua help_tags<cr>')
map('n', '<leader>fm', '<cmd>FzfLua man_pages<cr>')

local actions = require('fzf-lua.actions')
require('fzf-lua').setup {
	winopts = {
		border = 'single', -- 'none', 'single', 'double' or 'rounded' (default)
		preview = {
			hidden = 'hidden',
			vertical = 'down:45%', -- up|down:size
			horizontal = 'right:60%', -- right|left:size
			layout = 'flex',
			flip_columns = 120, -- #cols to switch to horizontal on flex
			scrollbar = 'float',
			scrolloff = '-2',
			delay = 0,
			winopts = {
				number = false,
				relativenumber = false,
				cursorline = true,
				cursorlineopt = 'both',
				cursorcolumn = false,
				signcolumn = 'no',
				list = false,
				foldenable = false,
				foldmethod = 'manual',
			}
		}
	},
	keymap = {
		-- These override the default tables completely
		-- no need to set to `false` to disable a bind
		-- delete or modify is sufficient
		builtin = {
			-- neovim `:tmap` mappings for the fzf win
			['<F2>'] = 'toggle-fullscreen',
			-- Only valid with the 'builtin' previewer
			['<c-space>'] = 'toggle-preview',
			-- Rotate preview clockwise/counter-clockwise
			['<c-d>'] = 'preview-page-down',
			['<c-u>'] = 'preview-page-up',
		},
		fzf = {
			-- fzf '--bind=' options
			['ctrl-z'] = 'abort',
			['ctrl-f'] = 'page-down',
			['ctrl-b'] = 'page-up',
			['ctrl-a'] = 'beginning-of-line',
			['ctrl-e'] = 'end-of-line',
			['alt-a'] = 'toggle-all',
		},
	},
	fzf_colors = {
		-- fzf '--color=' options (optional)
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
		multiprocess = true,  -- run command in a separate process
		git_icons = false,  -- show git icons?
		file_icons = false, -- show file icons?
		color_icons = false,  -- colorize file|git icons
		actions = {
			["alt-d"] = { function (selected)
				for _, file_name in ipairs(selected) do vim.fn.system('rm ' .. file_name) end
			end, actions.resume }
		}
	},
	git = {
		files = {
			cmd = 'git ls-files --exclude-standard',
			multiprocess = false,  -- run command in a separate process
			git_icons = false,  -- show git icons?
			file_icons = false, -- show file icons?
			color_icons = false,  -- colorize file|git icons
			-- force display the cwd header line regardles of your current working directory
			-- can also be used to hide the header when not wanted
			-- show_cwd_header = true
		},
		status = {
			file_icons = false,
			git_icons = false,
			color_icons = false,
		},
	},
	grep = {
		multiprocess = true,  -- run command in a separate process
		git_icons = false,  -- show git icons?
		file_icons = false, -- show file icons?
		color_icons = false,  -- colorize file|git icons
	},
	args = {
		files_only = true,
		-- added on top of regular file actions
		actions = { ['ctrl-x'] = actions.arg_del }
	},
	oldfiles = {
		cwd_only = false,
		file_icons = false,
		color_icons = false,
	},
	buffers = {
		file_icons = false,
		color_icons = false,
		-- sort_lastused = true,
	},
	quickfix = {
		file_icons = false,
		git_icons = false,
	},
	lsp = {
		jump_to_single_result = true,
		sync = true,
		async_or_timeout = 5000,
		cwd_only = false,
		file_icons = false,
		git_icons = false,
		lsp_icons = false,
		severity = 'hint',
		icons = {
			['Error'] = { icon = '', color = 'red' },  -- error
			['Warning'] = { icon = '', color = 'yellow' },  -- warning
			['Information'] = { icon = '', color = 'blue' },  -- info
			['Hint'] = { icon = '', color = 'magenta' }, -- hint
		},
	},
	-- uncomment to disable the previewer
	helptags = { previewer = { _ctor = false } },
	-- nvim = { marks = { previewer = { _ctor = false } } },
	-- manpages = { previewer = { _ctor = false } },
	-- uncomment to set dummy win location (help|man bar)
	-- 'topleft'	: up
	-- 'botright' : down
	-- helptags = { previewer = { split = 'topleft' } },
	-- uncomment to use `man` command as native fzf previewer
	manpages = { previewer = { _ctor = require'fzf-lua.previewer'.fzf.man_pages } },
	-- optional override of file extension icon colors
	-- available colors (terminal):
	--		clear, bold, black, red, green, yellow
	--		blue, magenta, cyan, grey, dark_grey, white
	-- padding can help kitty term users with
	-- double-width icon rendering
}

local M = {}

M.find_files_in = function()
	vim.ui.input({ prompt = 'directory: ' }, function(input)
		if input ~= nil and input ~= '' then
			require('fzf-lua').files({ cwd = input })
		end
	end)
end

M.grep_in = function()
	vim.ui.input({ prompt = 'directory: ' }, function(input)
		if input ~= nil and input ~= '' then
			require('fzf-lua').live_grep({ cwd = input })
		end
	end)
end

return M
