local cmp = require 'cmp'
local MAX_LABEL_WIDTH = 40
local ELLIPSIS_CHAR = '…'

cmp.setup {
  preselect = cmp.PreselectMode.None,
  mapping = {
    ['<c-e>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
    ['<c-y>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
    ['<c-n>'] = cmp.mapping.select_next_item(),
    ['<c-p>'] = cmp.mapping.select_prev_item(),
    ['<tab>'] = cmp.mapping.confirm({ select = true }),
    ['<c-l>'] = cmp.mapping.close(),
    ['<c-_>'] = cmp.mapping.abort(),
  },
  -- format pum max width
  formatting = {
    format = function(_, item)
      local truncated = vim.fn.strcharpart(item.abbr, 0, MAX_LABEL_WIDTH)
      if #truncated ~= #item.abbr then item.abbr = truncated .. ELLIPSIS_CHAR end
      return item
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' }
  })
}
