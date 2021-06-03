call plug#begin('$XDG_DATA_HOME/nvim/site/plugged')
" ====== a e s t h e t i c s
Plug 'sainnhe/gruvbox-material'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'junegunn/goyo.vim'
Plug 'szw/vim-maximizer'
Plug 'kyazdani42/nvim-tree.lua'
" ====== essentials
Plug 'rbgrouleff/bclose.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'windwp/nvim-autopairs'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'puremourning/vimspector'
Plug 'mbbill/undotree'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'pbondoer/vim-42header'
call plug#end()

source $XDG_CONFIG_HOME/nvim/plugins_conf/aesthetics.vim
source $XDG_CONFIG_HOME/nvim/plugins_conf/lsp.vim
source $XDG_CONFIG_HOME/nvim/plugins_conf/treesitter.vim
source $XDG_CONFIG_HOME/nvim/plugins_conf/vimspector.vim
source $XDG_CONFIG_HOME/nvim/plugins_conf/telescope.nvim.vim
source $XDG_CONFIG_HOME/nvim/plugins_conf/nvim-tree.vim

" miscellaneous
nnoremap <F5> :w<CR> <bar> :source $XDG_CONFIG_HOME/nvim/init.vim<CR>
nnoremap <F2> :Stdheader<CR>
" autopairs
lua require('nvim-autopairs').setup()
" undotree
nnoremap <leader>u :UndotreeToggle<CR>
" maximizer
let g:maximizer_set_default_mapping = 0
nnoremap <silent> <leader>m :MaximizerToggle<CR>
