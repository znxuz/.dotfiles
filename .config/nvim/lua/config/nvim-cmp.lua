local cmp = require 'cmp'
cmp.setup {
  mapping = {
    ['<c-e>'] = cmp.mapping(cmp.mapping.scroll_docs(5), { 'i', 'c' }),
    ['<c-y>'] = cmp.mapping(cmp.mapping.scroll_docs(-5), { 'i', 'c' }),
    ['<c-n>'] = cmp.mapping.select_next_item(),
    ['<c-p>'] = cmp.mapping.select_prev_item(),
    ['<c-l>'] = cmp.mapping.close(),
    -- ['<c-l>'] = cmp.mapping.complete(),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp', keyword_length = 3 },
    { name = 'buffer', keyword_length = 3 },
  })
}
