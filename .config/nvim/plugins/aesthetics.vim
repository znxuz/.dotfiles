" gruvbox-material config
	set termguicolors
	let g:gruvbox_material_background = 'hard'
	let g:gruvbox_material_enable_bold = 0
	let g:gruvbox_material_enable_italic = 0
	let g:gruvbox_material_disable_italic_comment = 0
	let g:gruvbox_material_sign_column_background = 'none'
	let g:gruvbox_material_lightline_disable_bold = 1
	colorscheme gruvbox-material
	set background=dark

" treesitter
lua << EOF
require 'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "cpp", "bash", "lua", "java", "comment" },
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

lua << EOF
local true_zen = require("true-zen")
true_zen.setup({
	modes = {
		ataraxis = {
			left_padding = 100,
			right_padding = 10,
			auto_padding = false,
			quit = "close",
			ignore_floating_windows = true,
		},
	},
})
true_zen.after_mode_ataraxis_on = function ()
	vim.api.nvim_set_keymap('c', 'bd', 'Bclose', {noremap = true})
end
true_zen.after_mode_ataraxis_off = function ()
	vim.api.nvim_command('cunmap bd')
end
EOF
nnoremap <leader>z <cmd>TZAtaraxis<cr>q:<c-w>c
