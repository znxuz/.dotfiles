local map = require("config.utils").map

vim.g["floaterm_width"] = 0.8
vim.g["floaterm_height"] = 0.8

map("n", "<m-cr>", "<cmd>FloatermToggle<cr>")
map("t", "<m-cr>", "<cmd>FloatermToggle<cr>")
map("t", "<c-d>", "<cmd>FloatermKill<cr>")
