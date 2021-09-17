" gruvbox-material config
	set termguicolors
	let g:gruvbox_material_background = 'hard'
	let g:gruvbox_material_enable_bold = 0
	let g:gruvbox_material_enable_italic = 0
	let g:gruvbox_material_disable_italic_comment = 0
	let g:gruvbox_material_sign_column_background = 'none'
	let g:gruvbox_material_lightline_disable_bold = 1
    let g:gruvbox_material_diagnostic_virtual_text = 'grey'
	colorscheme gruvbox-material
	set background=dark

" maximizer
	let g:maximizer_set_default_mapping = 0
	nnoremap <C-f> <CMD>MaximizerToggle<CR>

" treesitter
lua << EOF
require 'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "cpp", "bash", "lua", "comment" },
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
      relativenumber = true,
    },
  },
  on_open = function()
	vim.wo.colorcolumn = ""
	vim.api.nvim_set_keymap('c', 'bd', 'Bclose', {noremap = true})
	vim.api.nvim_set_keymap('c', 'q', 'qa', {noremap = true})
  end,
  on_close = function()
	vim.wo.colorcolumn = "80"
	vim.api.nvim_command('cunmap bd')
	vim.api.nvim_command('cunmap q')
  end,
  }
EOF
nnoremap <leader>z <CMD>ZenMode<CR>
