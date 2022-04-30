require('nvim-treesitter.configs').setup {
    ensure_installed = { 'c', 'cpp', 'bash', 'lua', 'comment' },
    highlight = {
	enable = true,
	additional_vim_regex_highlighting = false
    },
    autopairs = { enable = false },
    indent = { enable = false }
}
