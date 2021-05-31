lua << EOF
require('telescope').setup{
	defaults = {
		vimgrep_arguments = {
			'rg',
			'-u',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case'
		},
	prompt_position = "bottom",
	prompt_prefix = "> ",
	selection_caret = "> ",
	entry_prefix = "  ",
	initial_mode = "insert",
	selection_strategy = "reset",
	sorting_strategy = "descending",
	layout_strategy = "horizontal",
	layout_defaults = {
		horizontal = {
			mirror = false,
		},
		vertical = {
			mirror = false,
		},
	},
	file_sorter =  require'telescope.sorters'.get_fuzzy_file,
	file_ignore_patterns = {"Dropbox/",".git/",".cache/", ".dotfiles/","%.out","%.pdf"},
	generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
	shorten_path = true,
	winblend = 0,
	width = 0.75,
	preview_cutoff = 120,
	results_height = 1,
	results_width = 0.8,
	border = {},
	borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
	color_devicons = false,
	use_less = true,
	set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
	file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
	grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
	qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

	-- Developer configurations: Not meant for general override
	buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
	}
}
local actions = require('telescope.actions')
require('telescope').setup{
defaults = {
	mappings = {
		i = {
			["<esc>"] = actions.close
			},
		},
	}
}
EOF

nnoremap <leader>ff <cmd>Telescope find_files find_command=fd,-tf,-uu<CR>
nnoremap <leader>fd <cmd>Telescope find_files find_command=fd,-td,-uu<CR>
nnoremap <leader>fif :lua require('telescope.builtin').find_files({hidden=true,search_dirs={"$HOME/"}})<Left><Left><Left><Left>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>
