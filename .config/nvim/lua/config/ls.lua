-- load snippets from ./snippets
require("luasnip.loaders.from_vscode").lazy_load({ paths = "./snippets" })
require('config.mapper').map('n', "<leader>as", "<cmd>so ~/.config/nvim/lua/config/ls.lua | echo 'lua snippet sourced'<cr>")
