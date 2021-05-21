let mapleader=","

nnoremap <leader>rn :set rnu!<CR>
inoremap <leader>x <C-x><C-f>

" add terminal from below
nnoremap <leader>t :split \| terminal<CR>

" exact word search syntax
nnoremap <leader>/ /\<\><left><left>

" resize splits
nnoremap <leader>] :vertical resize +10<CR>
nnoremap <leader>[ :vertical resize -10<CR>

" control buffers
nnoremap <leader>h :bprev<CR>
nnoremap <leader>l :bnext<CR>
