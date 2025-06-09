vim.keymap.set('n', '<leader>L', '<Cmd>Lazy<Cr>')

function Fd(file_pattern, _)
  -- if first char is * then fuzzy search
  if file_pattern:sub(1, 1) == "*" then
    file_pattern = file_pattern:gsub(".", ".*%0") .. ".*"
  end
  local cmd = 'fd --color=never --full-path --type file --hidden "'
    .. file_pattern
    .. '"'
  return vim.fn.systemlist(cmd)
end
vim.opt.findfunc = "v:lua.Fd"
