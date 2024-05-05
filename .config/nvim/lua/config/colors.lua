require('config.bg')

-- change bg upon receiving SIGUSR1
vim.cmd([[
aug Update_bg
au!
au Signal SIGUSR1 luafile $HOME/.config/nvim/lua/config/bg.lua
aug END
]])

vim.cmd.colorscheme('rose-pine')
