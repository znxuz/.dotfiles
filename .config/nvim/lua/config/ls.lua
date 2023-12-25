local ls = require("luasnip")
local map = require('config.mapper').map

-- load snippets from ./snippets
require("luasnip.loaders.from_vscode").lazy_load({ paths = "./snippets" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(_)
    map({"i", "s"}, "<c-j>", function() ls.jump(1) end, {silent = true})
    map({"i", "s"}, "<c-k>", function() ls.jump(-1) end, {silent = true})
    map('n', "<leader>as", "<cmd>so ~/.config/nvim/lua/config/ls.lua | echo 'lua snippet sourced'<cr>")
  end,
})
