if &ft=="markdown"
  finish
endif

nnoremap <buffer> <leader>o <cmd>silent !$BROWSER %&<cr>
nnoremap <buffer> <leader>v <cmd>!html-validate %<cr>
inoremap <buffer> <leader>t <esc>F<wyiwA<><esc>PF<a/<esc>F<i
nnoremap <buffer> <leader>t <esc>F<wyiwA<><esc>PF<a/<esc>F<i<esc>
