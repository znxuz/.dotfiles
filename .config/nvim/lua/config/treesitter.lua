require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'cpp', 'bash', 'lua', 'rust', 'comment' },
  highlight = {
    enable = false,
    additional_vim_regex_highlighting = false
  },
  autopairs = { enable = false },
  indent = { enable = false },
  disable = function(buf)
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    if ok and stats and stats.size > max_filesize then
      return true
    end
  end
}
