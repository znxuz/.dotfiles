require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'cpp', 'bash', 'lua', 'latex', 'rust', 'toml', 'comment' },
  highlight = {
    enable = false,
    additional_vim_regex_highlighting = false
  },
  autopairs = { enable = false },
  indent = { enable = false },
}
