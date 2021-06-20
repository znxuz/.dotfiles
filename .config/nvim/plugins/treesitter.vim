lua << EOF
require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true	-- false will disable the whole extension
	},
	autopairs = {
		enable = false
	},
	indent = {
		enable = false
	}
}
EOF
