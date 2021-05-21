call plug#begin('$XDG_DATA_HOME/nvim/site/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

" a e s t h e t i c
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'

" essentials
Plug 'pbondoer/vim-42header'
Plug 'gruvbox-community/gruvbox'
Plug 'yegappan/mru'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'mbbill/undotree'
" telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
call plug#end()

" colors
colorscheme gruvbox
set background=dark
" when using transparent terminal background
" hi Normal guibg=NONE ctermbg=NONE

set completeopt=menuone,noinsert
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
lua require('lspconfig').clangd.setup{ on_attach=require'completion'.on_attach }
inoremap <expr> <TAB> pumvisible() ? "<C-y>" : "<TAB>"

let g:ranger_map_keys = 0
nnoremap <leader>g :Ranger<CR>

" centering
let g:goyo_width = 120
let g:goyo_linenr = 1
nnoremap <leader>c :Goyo<CR>

" bar
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
	  \ }

nnoremap qQ :MRU<CR>
let MRU_File = '$XDG_DATA_HOME/nvim/.vim_mru_files'

" nerdtree
nnoremap <leader>e :NERDTreeToggle<CR>
" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" telescope
source $XDG_CONFIG_HOME/nvim/telescope.nvim.vim
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>

nnoremap <leader>u :UndotreeToggle<CR>

nnoremap <F2> :Stdheader<CR>
nnoremap <F5> :source $XDG_CONFIG_HOME/nvim/init.vim<CR>
