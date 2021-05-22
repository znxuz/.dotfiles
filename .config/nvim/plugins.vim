call plug#begin('$XDG_DATA_HOME/nvim/site/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

" a e s t h e t i c
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
Plug 'mengelbrecht/lightline-bufferline'

" essentials
Plug 'pbondoer/vim-42header'
Plug 'gruvbox-community/gruvbox'
Plug 'yegappan/mru'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'preservim/nerdtree'
Plug 'mbbill/undotree'
Plug 'airblade/vim-rooter'

Plug 'windwp/nvim-autopairs'

" telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
call plug#end()

source $XDG_CONFIG_HOME/nvim/plugins_conf/lsp.vim
source $XDG_CONFIG_HOME/nvim/plugins_conf/aesthetics.vim
source $XDG_CONFIG_HOME/nvim/plugins_conf/telescope.nvim.vim

nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <F2> :Stdheader<CR>
nnoremap <F5> :w<CR> <bar> :source $XDG_CONFIG_HOME/nvim/init.vim<CR>

let g:ranger_map_keys = 0
nnoremap <leader>g :Ranger<CR>

nnoremap qQ :MRU<CR>
let MRU_File = '$XDG_DATA_HOME/nvim/.vim_mru_files'

" autopairs
lua require('nvim-autopairs').setup()

" nerdtree
nnoremap <leader>e :NERDTreeToggle<CR>
" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

