require('fzf-lua').setup {
  -- global_resume      = false, -- need to disable otherwise fzf_exec won't work
  global_resume_query = false,
  winopts = {
    border = 'single',
    hl = { border = 'LineNr' },
    height = 0.6,
    width = 0.6,
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
    path_shorten = true,
    multiprocess = true,  -- run command in a separate process
    git_icons = false,  -- show git icons?
    file_icons = false, -- show file icons?
    color_icons = false,  -- colorize file|git icons
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
    glob_flag = "--iglob",  -- for case sensitive globs use '--glob'
  },
  oldfiles = {
    cwd_only = false,
    file_icons = false,
    color_icons = false,
  },
  buffers = {
    path_shorten = true,
    file_icons = false,
    color_icons = false,
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
    severity = 'hint',
  },
  helptags = { previewer = { _ctor = false } },
  manpages = { previewer = { _ctor = false } },
}

local M = {}

M.find_files_in = function()
  vim.ui.input({ prompt = 'Files in: ', completion = "file" }, function(input)
    if input ~= nil and input ~= '' then
      require('fzf-lua').files({ cwd = input })
    end
  end)
end

M.grep_in = function()
  vim.ui.input({ prompt = 'Grep in: ', completion = "file" }, function(input)
    if input ~= nil and input ~= '' then
      require('fzf-lua').live_grep({ cwd = input })
    end
  end)
end

local map = require('config.mapper').map
map('n', '<leader>p', '<cmd>FzfLua files<cr>')
map('n', '<leader>cp', function () require('fzf-lua').files({ cwd = vim.fn.getcwd() }) end)
map('n', '<leader>ip', function () require("config.fzflua").find_files_in() end)
map('n', '<leader>b', '<cmd>FzfLua buffers<cr>')
map('n', '<leader>r', '<cmd>FzfLua live_grep<cr>')
map('n', '<leader>ir', function () require("config.fzflua").grep_in() end)
map('n', '<leader>A', '<cmd>FzfLua builtin<cr>')
map('n', '<leader>j', '<cmd>FzfLua jumps<cr>')
map('n', '<leader>h', '<cmd>FzfLua help_tags<cr>')
map('n', '<leader>k', '<cmd>FzfLua keymaps<cr>')

return M
