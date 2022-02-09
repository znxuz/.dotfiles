let g:nnn#set_default_mappings = 0
nnoremap <leader>nn <cmd>NnnPicker<cr>
nnoremap <leader>nc <cmd>NnnPicker %:p:h<cr>
let g:nnn#layout = { 'window': { 'width': 0.6, 'height': 0.6, 'highlight': 'Comment' } }
let g:nnn#action = {
            \ '<c-s>': 'split',
            \ '<c-v>': 'vsplit'
            \ }
