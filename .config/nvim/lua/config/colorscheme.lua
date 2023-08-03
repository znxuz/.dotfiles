require('config.bg')
vim.g['gruvbox_material_background'] = 'hard'
vim.g['gruvbox_material_sign_column_background'] = 'none'
vim.cmd 'color gruvbox-material'

-- custom highlight groups
vim.cmd 'hi! link PMenu StatusLine'
vim.cmd 'hi! link NormalFloat StatusLine'

-- change bg automatically upon receiving SIGUSR1
vim.cmd([[
aug Update_bg
au!
au Signal SIGUSR1 luafile $HOME/.config/nvim/lua/config/bg.lua
aug END
]])
