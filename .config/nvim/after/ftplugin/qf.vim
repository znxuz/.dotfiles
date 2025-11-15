nn <silent> <buffer> o <c-w>z<cr>
nn <silent> <buffer> p <cmd>execute 'pedit +' . get(getqflist(), line('.')-1, {'lnum': 1}).lnum . ' ' . expand('<cfile>')<cr>
nm <silent> <buffer> <cr> o<c-w>p<c-w>c

"nn <silent> <buffer> o <enter>
"" TODO use/instantiate preview window to preview
"nm <silent> <buffer> p o<c-w>p
"nm <silent> <buffer> <cr> p<c-w>c<c-w>p " c-w p in case there are multiple windows
