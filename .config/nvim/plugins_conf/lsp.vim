" lsp
set completeopt=menuone,noinsert
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
lua require('lspconfig').clangd.setup{ on_attach=require'completion'.on_attach }
inoremap <expr> <TAB> pumvisible() ? "<C-y>" : "<TAB>"
