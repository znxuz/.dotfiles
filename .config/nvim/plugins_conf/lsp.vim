" lsp
" completion https://github.com/nvim-lua/completion-nvim

set shortmess+=c
set completeopt=menuone,noinsert
let g:completion_trigger_keyword_length = 3
let g:completion_matching_strategy_list = ['exact', 'substring']
" let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
inoremap <expr> <TAB> pumvisible() ? "<C-y>" : "<TAB>"

" lsp language server
lua require('lspconfig').clangd.setup{ on_attach=require'completion'.on_attach }

" keybinds
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gh <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
" nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
