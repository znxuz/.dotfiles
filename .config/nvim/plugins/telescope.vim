lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
	defaults = {
		file_sorter =require('telescope.sorters').get_fzy_sorter,
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<C-s>"] = actions.select_horizontal,
			},
		},
		file_ignore_patterns = {".git/",".cache/", "%.out","%.pdf"},
		shorten_path = false,
	},
	pickers = {
		buffers = {
			theme = "dropdown",
			sort_lastused = true,
			mappings = { i = { ["<M-d>"] = actions.delete_buffer, }, }
		},
		find_files = { theme = "dropdown" },
		live_grep = { theme = "dropdown" },
		help_tags = { theme = "dropdown" },
		builtin = { theme = "dropdown" },
		jumplist = { theme = "dropdown" },
		oldfiles = { theme = "dropdown" },
		keymaps = { theme = "dropdown" },
		quickfix = { theme = "dropdown" },
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

nnoremap <leader>ff <CMD>Telescope find_files find_command=fd,-tf,-uu<CR>
nnoremap <leader>fc <CMD>lua require('telescope.builtin').find_files({hidden=true,search_dirs={"$HOME/.config/nvim"}})<CR>
nnoremap <leader>fb <CMD>Telescope buffers<CR>
nnoremap <leader>fg <CMD>Telescope live_grep<CR>
nnoremap <leader>fh <CMD>Telescope help_tags<CR>
nnoremap <leader>ft <CMD>Telescope builtin<CR>
nnoremap <leader>fj <CMD>Telescope jumplist<CR>
nnoremap <leader>fo <CMD>Telescope oldfiles<CR>
nnoremap <leader>fm <CMD>Telescope keymaps<CR>
nnoremap <leader>fq <CMD>Telescope quickfix<CR>
