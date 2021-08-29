set shortmess+=c
set signcolumn=yes

" completion
	set completeopt=menuone,noinsert,noselect
	let g:completion_trigger_keyword_length = 2
	let g:completion_matching_strategy_list = ['exact', 'substring']
	let g:completion_matching_ignore_case = 0
	let g:completion_matching_smart_case = 0
	let g:completion_confirm_key = ""

	imap <expr> <CR>  pumvisible() ? complete_info()["selected"] != "-1" ?
			\ "\<CR>"  : "\<CR>\<CR>" : "\<CR>"
	imap <silent> <C-n> <Plug>(completion_trigger)

" keybinds
	nnoremap <silent> gD <CMD>lua vim.lsp.buf.declaration()<CR>
	nnoremap <silent> gh <CMD>lua vim.lsp.buf.hover()<CR>
	nnoremap <silent> gd <CMD>Telescope lsp_definitions<CR>
	nnoremap <silent> gp <CMD>Telescope lsp_implementations<CR>
	nnoremap <silent> gr <CMD>Telescope lsp_references<CR>
	inoremap <silent> <leader>gh <CMD>lua vim.lsp.buf.signature_help()<CR>
	nnoremap <silent> <leader>gre <CMD>lua vim.lsp.buf.rename()<CR>
	nnoremap <silent> <leader>gen <CMD>lua vim.lsp.diagnostic.goto_prev()<CR>
	nnoremap <silent> <leader>gep <CMD>lua vim.lsp.diagnostic.goto_next()<CR>
	nnoremap <silent> <leader>fsd <CMD>Telescope lsp_dynamic_workspace_symbols<CR>
	nnoremap <silent> <leader>fsc <CMD>Telescope lsp_document_symbols<CR>
	nnoremap <silent> <leader>gea <CMD>Telescope lsp_workspace_diagnostics<CR>
	nnoremap <silent> <leader>gec <CMD>Telescope lsp_document_diagnostics<CR>

" language servers https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md

" C
	let g:c_syntax_for_h = 1
	lua require('lspconfig').clangd.setup{ on_attach=require'completion'.on_attach }
	nnoremap <silent> <leader>s :ClangdSwitchSourceHeader<CR>

" lua
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
	cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
				path = vim.split(package.path, ';')
			},
			diagnostics = { globals = {'vim'} },
				-- Get the language server to recognize the `vim` global
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = { enable = false },
		},
	},
	on_attach = require'completion'.on_attach
}
EOF
