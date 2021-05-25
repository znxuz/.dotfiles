" lsp
" completion https://github.com/nvim-lua/completion-nvim

set shortmess+=c
set completeopt=menuone,noinsert
let g:completion_enable_auto_paren = 1
let g:completion_trigger_keyword_length = 2
let g:completion_matching_strategy_list = ['exact'] " ['exact', 'substring', 'fuzzy', 'all']
let g:completion_confirm_key = "\<C-y>"
imap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"

" C language server
lua require('lspconfig').clangd.setup{ on_attach=require'completion'.on_attach }
nnoremap <silent> <A-s> :ClangdSwitchSourceHeader<CR>

" keybinds
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gh <cmd>lua vim.lsp.buf.hover()<CR>
inoremap <silent> <A-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gp <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <leader>re <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>gen <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <leader>gep <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
