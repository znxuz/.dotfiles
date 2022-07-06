-- [[
--language servers https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--]]

local map = require('config.utils').map
local lsp = require('lspconfig')

vim.cmd 'set shortmess+=c'
vim.cmd 'set signcolumn=yes'
vim.cmd 'set pumheight=10'

map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
map('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<cr>')
map('n', 'gd', '<cmd>FzfLua lsp_definitions<cr>')
map('n', 'gD', '<cmd>FzfLua lsp_typedefs<cr>')
map('n', 'gr', '<cmd>FzfLua lsp_references<cr>')
map('i', '<m-l>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
map('n', '<leader>a', '<cmd>FzfLua lsp_code_actions<cr>')
map('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>')
map('n', '<leader>s', '<cmd>FzfLua lsp_document_symbols<cr>')
map('n', '<leader>S', '<cmd>FzfLua lsp_live_workspace_symbols<cr>')
map('n', '<leader>E', '<cmd>FzfLua lsp_workspace_diagnostics<cr>')
map('n', '<leader>e', '<cmd>FzfLua lsp_document_diagnostics<cr>')
map('n', '<leader>pe', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
map('n', '<leader>ne', '<cmd>lua vim.diagnostic.goto_next()<cr>')
map('n', '<leader>ce', '<cmd>lua vim.diagnostic.open_float()<cr>')

-- C/CPP
lsp.clangd.setup {
    cmd = { 'clangd', '--background-index', '--log=error' }
}
map('n', '<leader><c-^>', '<cmd>ClangdSwitchSourceHeader<cr>')

-- Tex
lsp.texlab.setup {}

-- Lua
--[[
USER = vim.fn.expand('$USER')
local sumneko_root_path = ''
local sumneko_binary = ''
if vim.fn.has('unix') == 1 then
    sumneko_root_path = '/usr/share/lua-language-server'
    sumneko_binary = '/usr/bin/lua-language-server'
else
    print('Unsupported system for sumneko')
end
lsp.sumneko_lua.setup {
    cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
    settings = {
	Lua = {
	    runtime = {
		version = 'LuaJIT',
		path = vim.split(package.path, ';')
	    },
	    diagnostics = { globals = {'vim'} },
	    workspace = { library = vim.api.nvim_get_runtime_file('', true), },
	    telemetry = { enable = false },
	},
    },
}
--]]
