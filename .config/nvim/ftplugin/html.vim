if &ft=="markdown"
    finish
endif

nnoremap <buffer> <leader>o <cmd>silent !$BROWSER %&<cr>
nnoremap <buffer> <leader>v <cmd>!html-validate %<cr>
nnoremap <buffer> <leader>l <esc>F<wyiwA<><esc>PF<a/<esc>F<i<esc>
inoremap <buffer> <m-l> <esc>F<wyiwA<><esc>PF<a/<esc>F<i
