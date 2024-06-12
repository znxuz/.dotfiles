require('nvim-treesitter.configs').setup {
	ensure_installed = {
		'c',
		'lua',
		'vim',
		'vimdoc',
		'query',
		'cpp',
		'bash',
		'latex',
		'rust',
		'toml',
		'comment'
	},
	highlight = {
		enable = false,
		additional_vim_regex_highlighting = false
	},
	autopairs = { enable = false },
	indent = { enable = false },
}

require'treesitter-context'.setup {
  enable = false,
  max_lines = 0,
  min_window_height = 0,
  line_numbers = true,
  multiline_threshold = 20,
  trim_scope = 'outer',
  mode = 'cursor',
  separator = nil,
  zindex = 20,
  on_attach = nil,
}
require('config.mapper').map('n', '<leader>ac', '<cmd>TSContextToggle<cr>')
