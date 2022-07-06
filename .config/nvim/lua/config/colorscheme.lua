require('config.bg')
vim.g['gruvbox_material_background'] = 'hard'
vim.g['gruvbox_material_sign_column_background'] = 'none'
vim.cmd 'color gruvbox-material'

-- custom highlight groups
vim.cmd 'hi! link PMenu StatusLine'
vim.cmd 'hi! link NormalFloat StatusLine'
