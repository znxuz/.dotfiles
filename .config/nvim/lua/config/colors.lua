require('config.bg')
vim.g['gruvbox_material_background'] = 'hard'
vim.g['gruvbox_material_sign_column_background'] = 'none'
vim.cmd 'color gruvbox-material'

-- change highlight groups automatically upon switching bg
vim.cmd([[
aug Custom_Hi
au!
au ColorScheme * hi! link PMenu StatusLine | hi! link NormalFloat StatusLine
aug END
]])
vim.cmd'doau ColorScheme'

-- change bg automatically upon receiving SIGUSR1
vim.cmd([[
aug Update_bg
au!
au Signal SIGUSR1 luafile $HOME/.config/nvim/lua/config/bg.lua
aug END
]])
