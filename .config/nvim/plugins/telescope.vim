lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
	defaults = {
		prompt_prefix = " ❯ ",
		layout_config = { prompt_position = "top", },
		sorting_strategy = "ascending",
		file_sorter = require('telescope.sorters').get_fzy_sorter,
		file_ignore_patterns = {".git/", ".cache", "%.o", "%.out", "%.class", "%.pdf"},
		shorten_path = false,
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<C-s>"] = actions.select_horizontal,
			},
		},
	},
	pickers = {
		find_files = { hidden = true, no_ignore = true, },
		file_browser = { hidden = true, no_ignore = true, },
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		}
	}
}
require('telescope').load_extension('fzy_native')
EOF

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fa <cmd>Telescope find_files search_dirs=~<cr>
nnoremap <leader>fc <cmd>Telescope find_files search_dirs=%:p:h<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fdd <cmd>Telescope file_browser<cr>
nnoremap <leader>fdc <cmd>Telescope file_browser cwd=%:p:h<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>ft <cmd>Telescope builtin<cr>
nnoremap <leader>fj <cmd>Telescope jumplist<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles<cr>
nnoremap <leader>fm <cmd>Telescope keymaps<cr>
nnoremap <leader>fq <cmd>Telescope quickfix<cr>
