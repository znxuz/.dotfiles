require('config.bg')

vim.g['gruvbox_material_background'] = 'hard'
vim.g['gruvbox_material_sign_column_background'] = 'none'
vim.cmd 'color gruvbox-material'

vim.cmd 'hi! link PMenu StatusLine | hi! link NormalFloat StatusLine | hi! link TabLine StatusLine'

-- change bg & set custom highlights upon receiving SIGUSR1
vim.cmd([[
  aug Update_bg
  au!
  au Signal SIGUSR1 luafile $XDG_CONFIG_HOME/nvim/lua/config/bg.lua
  au Signal SIGUSR1 hi! link PMenu StatusLine | hi! link NormalFloat StatusLine
  aug END
]])
