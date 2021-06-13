lua << EOF
local actions = require('telescope.actions')
require('telescope').setup{
	defaults = {
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<C-s>"] = actions.select_horizontal,
			},
		},
	file_ignore_patterns = {"Dropbox/",".git/",".cache/", ".dotfiles/","%.out","%.pdf"},
	shorten_path = false,
	}
}
EOF

" nnoremap <leader>ff <CMD>Telescope find_files find_command=fd,-tf,-uu theme=get_dropdown<CR>
nnoremap <leader>ff <CMD>Telescope find_files find_command=fd,-tf,-uu<CR>
nnoremap <leader>fc <CMD>lua require('telescope.builtin').find_files({hidden=true,search_dirs={"$HOME/.config/nvim"}})<CR>
nnoremap <leader>fg <CMD>Telescope live_grep<CR>
nnoremap <leader>fb <CMD>Telescope buffers<CR>
nnoremap <leader>fh <CMD>Telescope help_tags<CR>
nnoremap <leader>ft <CMD>Telescope builtin<CR>
