call plug#begin('$XDG_DATA_HOME/nvim/site/plugged')
" a e s t h e t i c s
Plug 'sainnhe/gruvbox-material'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" essentials
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'yegappan/mru'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'mbbill/undotree'
Plug 'airblade/vim-gitgutter'
Plug 'windwp/nvim-autopairs'
" Plug 'airblade/vim-rooter'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'pbondoer/vim-42header'
call plug#end()

source $XDG_CONFIG_HOME/nvim/plugins_conf/aesthetics.vim
source $XDG_CONFIG_HOME/nvim/plugins_conf/lsp.vim
source $XDG_CONFIG_HOME/nvim/plugins_conf/telescope.nvim.vim
source $XDG_CONFIG_HOME/nvim/plugins_conf/ntree.vim
source $XDG_CONFIG_HOME/nvim/plugins_conf/treesitter.vim

" plugins miscs
nnoremap <F2> :Stdheader<CR>
nnoremap <F5> :wa<CR> <bar> :source $XDG_CONFIG_HOME/nvim/init.vim<CR>

let g:ranger_map_keys = 0
nnoremap <leader>g :Ranger<CR>

nnoremap qQ :MRU<CR>
let MRU_File = '$XDG_DATA_HOME/nvim/.vim_mru_files'

" autopairs
lua require('nvim-autopairs').setup()
