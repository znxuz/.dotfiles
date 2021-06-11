lua <<EOF
require('nvim-autopairs').setup {
    check_ts = true
}

require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true	-- false will disable the whole extension
	},
	autopairs = {
		enable = true
	},
	indent = {
		enable = false
	}
}
