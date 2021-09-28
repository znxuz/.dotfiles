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
  require("zen-mode").setup {
  window = {
    backdrop = 1,
    width = 100,
    height = 0.9,
    options = {
      signcolumn = "yes",
      number = true,
    },
  },
  on_open = function()
	vim.wo.colorcolumn = ""
	vim.api.nvim_set_keymap('c', 'bd', 'Bclose', {noremap = true})
  end,
  on_close = function()
	vim.wo.colorcolumn = "80"
	vim.api.nvim_command('cunmap bd')
  end,
  }
EOF
nnoremap <leader>z <CMD>ZenMode<CR>
