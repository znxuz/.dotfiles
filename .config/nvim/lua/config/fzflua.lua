local actions = require('fzf-lua.actions')
require('fzf-lua').setup {
    global_resume      = false,
    global_resume_query = false,
    winopts = {
	border = 'single',
	hl = { border = 'LineNr' },
	preview = {
	    hidden = 'hidden',
	    vertical = 'down:45%',
	    horizontal = 'right:60%',
	    layout = 'flex',
	    flip_columns = 120,
	    scrollbar = 'float',
	    scrolloff = '-2',
	    delay = 0,
	    winopts = {
		number = true,
		relativenumber = false,
		cursorline = false,
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
	builtin = {
	    ['<c-space>'] = 'toggle-preview',
	    ['<c-d>'] = 'preview-page-down',
	    ['<c-u>'] = 'preview-page-up',
	},
	fzf = {
	    -- fzf '--bind=' options
	    ['alt-a'] = 'toggle-all',
	    ['ctrl-a'] = 'beginning-of-line',
	    ['ctrl-e'] = 'end-of-line',
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
    helptags = { previewer = { _ctor = false } },
    manpages = { previewer = { _ctor = false } },
}

local M = {}

M.find_files_in = function()
    vim.ui.input({ prompt = 'Files in: ' }, function(input)
	if input ~= nil and input ~= '' then
	    require('fzf-lua').files({ cwd = input })
	end
    end)
end

M.grep_in = function()
    vim.ui.input({ prompt = 'Grep in: ' }, function(input)
	if input ~= nil and input ~= '' then
	    require('fzf-lua').live_grep({ cwd = input })
	end
    end)
end

local map = require('config.utils').map
map('n', '<leader>f', '<cmd>FzfLua files<cr>')
map('n', '<leader>F', '<cmd>FzfLua files cwd=~<cr>')
map('n', '<leader>cf', '<cmd>FzfLua files cwd=%:h<cr>')
map('n', '<leader>if', '<cmd>lua require("config.fzflua").find_files_in()<cr>')
map('n', '<leader>b', '<cmd>FzfLua buffers<cr>')
map('n', '<leader>g', '<cmd>FzfLua live_grep<cr>')
map('n', '<leader>cg', '<cmd>FzfLua live_grep cwd=%:p:h<cr>')
map('n', '<leader>ig', '<cmd>lua require("config.fzflua").grep_in()<cr>')
map('n', '<leader>A', '<cmd>FzfLua builtin<cr>')
map('n', '<leader>j', '<cmd>FzfLua jumps<cr>')
map('n', '<leader>h', '<cmd>FzfLua help_tags<cr>')
map('n', '<leader>m', '<cmd>FzfLua man_pages<cr>')

return M
