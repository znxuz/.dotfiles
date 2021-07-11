" gruvbox-material config
	let g:gruvbox_material_background = 'hard'
	let g:gruvbox_material_enable_bold = 0
	let g:gruvbox_material_enable_italic = 0
	let g:gruvbox_material_disable_italic_comment = 0
	let g:gruvbox_material_sign_column_background = 'none'
	let g:gruvbox_material_lightline_disable_bold = 1
	set termguicolors
	colorscheme gruvbox-material
	set background=dark

" maximizer
	let g:maximizer_set_default_mapping = 0
	nnoremap <C-f> <CMD>MaximizerToggle<CR>

" treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "cpp", "bash", "comment" },
	highlight = {
		enable = true
	},
	autopairs = {
		enable = false
	},
	indent = {
		enable = false
	}
}
EOF

" zen mode
lua << EOF
require("zen-mode").setup {
	window = {
		backdrop = 1,
		width = 86,
		height = 1,
		options = {
			signcolumn = "yes",
			number = true,
			relativenumber = true,
		},
	},
}
EOF
nnoremap <leader>z <CMD>ZenMode<CR>
