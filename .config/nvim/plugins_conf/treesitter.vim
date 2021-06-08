lua <<EOF
require('nvim-autopairs').setup {
    check_ts = true
}

require'nvim-treesitter.configs'.setup {
	autopairs = {
		enable = true
	},
	highlight = {
		enable = true	-- false will disable the whole extension
	},
	indent = {
		enable = false
	}
}
