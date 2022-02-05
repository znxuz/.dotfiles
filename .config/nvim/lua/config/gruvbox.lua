vim.g["gruvbox_material_background"] = "hard"
vim.g["gruvbox_material_enable_bold"] = 0
vim.g["gruvbox_material_enable_italic"] = 0
vim.g["gruvbox_material_disable_italic_comment"] = 0
vim.g["gruvbox_material_sign_column_background"] = "none"
vim.g["gruvbox_material_lightline_disable_bold"] = 1
vim.o.termguicolors = true
vim.o.background = "dark"
vim.cmd "colorscheme gruvbox-material"

-- custom highlight groups
vim.cmd "hi! link FloatermBorder None"
vim.cmd "hi! link PMenu StatusLine"
vim.cmd "hi! link NormalFloat StatusLine"
vim.cmd "hi default link STLMode WildMenu | hi default link STL StatusLineNC"
