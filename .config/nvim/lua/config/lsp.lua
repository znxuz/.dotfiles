-- language servers https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
local map = require("config.utils").map
local lsp = require("lspconfig")

vim.cmd "set shortmess+=c"
vim.cmd "set signcolumn=yes"
vim.cmd "set completeopt=menuone,noinsert,noselect"

map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
map("n", "gh", "<cmd>lua vim.lsp.buf.hover()<cr>")
map("n", "gd", "<cmd>Telescope lsp_definitions<cr>")
map("n", "gp", "<cmd>Telescope lsp_implementations<cr>")
map("n", "gr", "<cmd>Telescope lsp_references<cr>")
map("i", "<leader>gh", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
map("n", "<leader>gre", "<cmd>lua vim.lsp.buf.rename()<cr>")
map("n", "<leader>fss", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>")
map("n", "<leader>fsc", "<cmd>Telescope lsp_document_symbols<cr>")
map("n", "<leader>gee", "<cmd>Telescope lsp_workspace_diagnostics<cr>")
map("n", "<leader>gec", "<cmd>Telescope lsp_document_diagnostics<cr>")
map("n", "<leader>gep", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
map("n", "<leader>gen", "<cmd>lua vim.diagnostic.goto_next()<cr>")
map("n", "<leader>ges", "<cmd>lua vim.diagnostic.open_float()<cr>")

-- Tex
lsp.texlab.setup{}

-- C
vim.g["c_syntax_for_h"] = 1
require "lspconfig".clangd.setup{}
map("n", "<leader>s", "<cmd>ClangdSwitchSourceHeader<cr>")

-- Lua
USER = vim.fn.expand("$USER")
local sumneko_root_path = ""
local sumneko_binary = ""
if vim.fn.has("unix") == 1 then
	sumneko_root_path = "/usr/share/lua-language-server"
	sumneko_binary = "/usr/bin/lua-language-server"
else
	print("Unsupported system for sumneko")
end
lsp.sumneko_lua.setup {
	cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ";")
			},
			diagnostics = { globals = {"vim"} },
			workspace = { library = vim.api.nvim_get_runtime_file("", true), },
			telemetry = { enable = false },
		},
	},
}

-- Java
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>")
map("v", "<leader>ca", "<esc><cmd>lua vim.lsp.buf.range_code_action()<cr>")
map("n", "<leader>ci", "<cmd>lua require('jdtls').organize_imports()<cr>")
map("i", "<leader>ci", "<cmd>lua require('jdtls').organize_imports()<cr>")
-- <cmd>lua require('jdtls').extract_variable()<cr>
-- <esc><cmd>lua require('jdtls').extract_variable(true)<cr>
-- <cmd>lua require('jdtls').extract_constant()<cr>
-- <esc><cmd>lua require('jdtls').extract_constant(true)<cr>
-- <esc><cmd>lua require('jdtls').extract_method(true)<cr>

-- HTML
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
lsp.html.setup {
	capabilities = capabilities,
}
lsp.cssls.setup {
  capabilities = capabilities,
}
