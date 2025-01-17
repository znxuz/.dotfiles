return {
	'nvim-treesitter/nvim-treesitter',
	lazy = true,
	build = ":TSUpdate",
	config = function()
		require 'nvim-treesitter.configs'.setup {
			ensure_installed = {
				'markdown',
				'vimdoc',
				'c',
				'cpp',
				'lua',
				'bash',
				'rust',
				'vim',
				'query',
				'latex', -- binary in package `treesitter-cli` in PATH needed
				'toml',
				'comment',
				'yaml',
			},
			highlight = {
				enable = false,
				additional_vim_regex_highlighting = false
			},
			autopairs = { enable = false },
			indent = { enable = false },
		}
	end

}
