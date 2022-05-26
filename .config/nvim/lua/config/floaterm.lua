vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.8
vim.cmd 'hi! link FloatermBorder None'

local map = require('config.utils').map
map('n', '<m-cr>', '<cmd>FloatermToggle<cr>')
map('t', '<m-cr>', '<cmd>FloatermToggle<cr>')
