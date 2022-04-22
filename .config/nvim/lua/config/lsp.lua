-- [[
--language servers https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--]]

local map = require('config.utils').map
local lsp = require('lspconfig')

vim.cmd 'set shortmess+=c'
vim.cmd 'set signcolumn=yes'
vim.cmd 'set completeopt=menuone,noinsert'
vim.cmd 'set pumheight=10'

map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
map('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<cr>')
map('n', 'gd', '<cmd>FzfLua lsp_definitions<cr>')
map('n', 'gD', '<cmd>FzfLua lsp_typedefs<cr>')
map('n', 'gp', '<cmd>FzfLua lsp_implementations<cr>')
map('n', 'gr', '<cmd>FzfLua lsp_references<cr>')
map('i', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
map('n', '<leader>re', '<cmd>lua vim.lsp.buf.rename()<cr>')
map('n', '<leader>ca', '<cmd>FzfLua lsp_code_actions<cr>')
map('n', '<leader>ss', '<cmd>FzfLua lsp_live_workspace_symbols<cr>')
map('n', '<leader>sc', '<cmd>FzfLua lsp_document_symbols<cr>')
map('n', '<leader>ee', '<cmd>FzfLua lsp_workspace_diagnostics<cr>')
map('n', '<leader>ec', '<cmd>FzfLua lsp_document_diagnostics<cr>')
map('n', '<leader>ep', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
map('n', '<leader>en', '<cmd>lua vim.diagnostic.goto_next()<cr>')
map('n', '<leader>es', '<cmd>lua vim.diagnostic.open_float()<cr>')

-- Tex
lsp.texlab.setup{}

-- C/CPP
lsp.clangd.setup {
	cmd = { 'clangd', '--background-index', '--log=error' }
}
map('n', '<leader><c-^>', '<cmd>ClangdSwitchSourceHeader<cr>')

-- Lua
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

-- HTML
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
lsp.html.setup { capabilities = capabilities }
lsp.cssls.setup { capabilities = capabilities }
