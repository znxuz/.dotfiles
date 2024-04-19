require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'cpp', 'bash', 'html',     -- html for devdocs
  'latex', 'rust', 'toml', 'comment'  },
  highlight = {
    enable = false,
    additional_vim_regex_highlighting = false
  },
  autopairs = { enable = false },
  indent = { enable = false },
}
