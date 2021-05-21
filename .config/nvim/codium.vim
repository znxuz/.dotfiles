" basics
set guicursor=n-v-c-a:hor1,i-ci-c:ver1
set clipboard=unnamedplus

" search 
set incsearch
set nohlsearch
set ignorecase
set smartcase
nnoremap <silent> // :let @/ = ""<CR>

" add numbered jk to jumplist
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

nnoremap q <Nop>
nnoremap qr q
nmap Q ZQ<CR>
nmap qq ZZ<CR>

nnoremap <silent> qQ <Cmd>call VSCodeNotify('workbench.action.reopenClosedEditor')<CR>

" let mapleader=","
" nnoremap <silent> <leader>h <Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>
" nnoremap <silent> <leader>l <Cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>
