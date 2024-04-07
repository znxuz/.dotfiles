require('config.bg')

-- change bg & set custom highlights upon receiving SIGUSR1
vim.cmd([[
  aug Update_bg
  au!
  au Signal SIGUSR1 luafile $XDG_CONFIG_HOME/nvim/lua/config/bg.lua
  aug END
]])

vim.cmd.colorscheme('rose-pine')
