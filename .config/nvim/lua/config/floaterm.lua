local map = require('config.utils').map

vim.g['floaterm_width'] = 0.75
vim.g['floaterm_height'] = 0.75

map('n', '<m-cr>', '<cmd>FloatermToggle<cr>')
map('t', '<m-cr>', '<cmd>FloatermToggle<cr>')
map('t', '<c-d>', '<cmd>FloatermKill<cr>')
