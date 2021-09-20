lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
	defaults = {
		prompt_prefix = " ❯ ",
		layout_config = { prompt_position = "top", },
		sorting_strategy = "ascending",
		file_sorter = require('telescope.sorters').get_fzy_sorter,
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<C-s>"] = actions.select_horizontal,
			},
		},
		file_ignore_patterns = {".git/", ".cache", "%.o", "%.out", "%.pdf"},
		shorten_path = false,
	},
	pickers = {
		buffers = { 
			mappings = { i = { ["<leader>d"] = actions.delete_buffer, } },
			-- sort_lastused = true,
		},
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

nnoremap <leader>ff <CMD>Telescope find_files<CR>
nnoremap <leader>fa <CMD>Telescope find_files search_dirs=~<CR>
nnoremap <leader>fc <CMD>Telescope find_files search_dirs=%:p:h<CR>
nnoremap <leader>fb <CMD>Telescope buffers<CR>
nnoremap <leader>fdd <CMD>Telescope file_browser<CR>
nnoremap <leader>fdc <CMD>Telescope file_browser cwd=%:p:h<CR>
nnoremap <leader>fg <CMD>Telescope live_grep<CR>
nnoremap <leader>fh <CMD>Telescope help_tags<CR>
nnoremap <leader>ft <CMD>Telescope builtin<CR>
nnoremap <leader>fj <CMD>Telescope jumplist<CR>
nnoremap <leader>fo <CMD>Telescope oldfiles<CR>
nnoremap <leader>fm <CMD>Telescope keymaps<CR>
nnoremap <leader>fq <CMD>Telescope quickfix<CR>
