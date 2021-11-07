set shortmess+=c
set signcolumn=yes
set completeopt=menuone,noinsert,noselect

" nvim-cmp
lua << EOF
local cmp = require 'cmp'

cmp.setup {
	snippet = {
		expand = function(args)
		require('luasnip').lsp_expand(args.body)
		end,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-l>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<C-y>'] = cmp.mapping.confirm { select = true, },
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'buffer', keyword_length = 3 },
		{ name = 'luasnip' },
	})
}
EOF

" keybinds
	nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<cr>
	nnoremap <silent> gh <cmd>lua vim.lsp.buf.hover()<cr>
	nnoremap <silent> gd <cmd>Telescope lsp_definitions<cr>
	nnoremap <silent> gp <cmd>Telescope lsp_implementations<cr>
	nnoremap <silent> gr <cmd>Telescope lsp_references<cr>
	inoremap <silent> <leader>gh <cmd>lua vim.lsp.buf.signature_help()<cr>
	nnoremap <silent> <leader>gre <cmd>lua vim.lsp.buf.rename()<cr>
	nnoremap <silent> <leader>fss <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
	nnoremap <silent> <leader>fsc <cmd>Telescope lsp_document_symbols<cr>
	nnoremap <silent> <leader>gee <cmd>Telescope lsp_workspace_diagnostics<cr>
	nnoremap <silent> <leader>gec <cmd>Telescope lsp_document_diagnostics<cr>
	nnoremap <silent> <leader>gep <cmd>lua vim.lsp.diagnostic.goto_prev()<cr>
	nnoremap <silent> <leader>gen <cmd>lua vim.lsp.diagnostic.goto_next()<cr>

" language servers https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md

" C
	let g:c_syntax_for_h = 1
	lua require('lspconfig').clangd.setup{}
	nnoremap <silent> <leader>s :ClangdSwitchSourceHeader<cr>

" Lua
lua << EOF
USER = vim.fn.expand('$USER')
local sumneko_root_path = ""
local sumneko_binary = ""
if vim.fn.has("unix") == 1 then
	sumneko_root_path = "/usr/share/lua-language-server"
	sumneko_binary = "/usr/bin/lua-language-server"
else
	print("Unsupported system for sumneko")
end
require'lspconfig'.sumneko_lua.setup {
	cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
				path = vim.split(package.path, ';')
			},
			diagnostics = { globals = {'vim'} },
			workspace = { library = vim.api.nvim_get_runtime_file("", true), },
			telemetry = { enable = false },
		},
	},
}
EOF

" Java
nnoremap <leader>ca <cmd>lua require('jdtls').code_action()<cr>
vnoremap <leader>ca <esc><cmd>lua require('jdtls').code_action(true)<cr>
nnoremap <leader>cr <cmd>lua require('jdtls').code_action(false, 'refactor')<cr>
nnoremap <leader>ci <cmd>lua require('jdtls').organize_imports()<cr>
inoremap <leader>ci <cmd>lua require('jdtls').organize_imports()<cr>
" <cmd>lua require('jdtls').extract_variable()<cr>
" <esc><cmd>lua require('jdtls').extract_variable(true)<cr>
" <cmd>lua require('jdtls').extract_constant()<cr>
" <esc><cmd>lua require('jdtls').extract_constant(true)<cr>
" <esc><cmd>lua require('jdtls').extract_method(true)<cr>

" HTML
lua << EOF
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
	capabilities = capabilities,
}
require'lspconfig'.cssls.setup {
  capabilities = capabilities,
}
EOF
