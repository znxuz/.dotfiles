set shortmess+=c
set signcolumn=yes

" completion
set completeopt=menuone,noinsert
let g:completion_enable_auto_paren = 0
let g:completion_trigger_keyword_length = 2
let g:completion_matching_strategy_list = ['exact']
let g:completion_confirm_key = "\<C-y>"
imap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"
imap <silent> <c-p> <Plug>(completion_trigger)

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

" C language server
	lua require('lspconfig').clangd.setup{ on_attach=require'completion'.on_attach }
	nnoremap <silent> <leader>s :ClangdSwitchSourceHeader<CR>
