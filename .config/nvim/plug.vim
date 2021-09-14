call plug#begin('$XDG_DATA_HOME/nvim/site/plugged')
" ====== a e s t h e t i c s
	Plug 'sainnhe/gruvbox-material'
	Plug 'szw/vim-maximizer'
	Plug 'folke/zen-mode.nvim'
	Plug 'rbgrouleff/bclose.vim'
	Plug 'nvim-treesitter/nvim-treesitter'
" ====== essentials
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'nvim-telescope/telescope-fzy-native.nvim'
	Plug 'neovim/nvim-lspconfig'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'saadparwaiz1/cmp_luasnip'
	Plug 'L3MON4D3/LuaSnip'
	Plug 'mfussenegger/nvim-dap'
	Plug 'rcarriga/nvim-dap-ui'
	Plug 'mfussenegger/nvim-jdtls'
	Plug 'mbbill/undotree'
	Plug 'vimwiki/vimwiki', { 'on': 'VimwikiUISelect' }
" ====== useless garbage
	Plug 'pbondoer/vim-42header'
call plug#end()

" gotta source
	source $XDG_CONFIG_HOME/nvim/plugins/aesthetics.vim
	source $XDG_CONFIG_HOME/nvim/plugins/telescope.vim
	source $XDG_CONFIG_HOME/nvim/plugins/lsp.vim
	source $XDG_CONFIG_HOME/nvim/plugins/nvim_dap.vim
	source $XDG_CONFIG_HOME/nvim/plugins/vimwiki.vim

" miscellaneous
	nnoremap <F5> <CMD>w \| source $XDG_CONFIG_HOME/nvim/init.vim<CR>
	nnoremap <F2> <CMD>Stdheader<CR>
	nnoremap <leader>u <CMD>UndotreeToggle<CR>
	nnoremap <leader>bd <CMD>Bclose<CR>
