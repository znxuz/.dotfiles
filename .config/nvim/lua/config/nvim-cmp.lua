local cmp = require('cmp')
local MAX_LABEL_WIDTH = 40
local ELLIPSIS_CHAR = '…'
local compare = cmp.config.compare

cmp.setup {
  enabled = function () -- disables completion for the cli(q:) window
    if vim.fn.bufname("%") == "[Command Line]" then return false else return true end
  end,
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args) require'luasnip'.lsp_expand(args.body) end,
  },
  sorting = {
    priority_weight = 1.0,
    comparators = {
      compare.score,
      compare.recently_used,
      compare.locality,
      compare.order,
      compare.length,
      compare.offset,
    },
  },
  mapping = {
    ['<c-e>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
    ['<c-y>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
    ['<tab>'] = cmp.mapping.confirm({ select = true }),
    --[[
    ['<tab>'] = cmp.mapping(function (fallback)
      if cmp.visible() then
        cmp.confirm({ select = true })
      elseif  ls.jumpable(1) then
        ls.jump(1)
      else
        fallback()
      end
    end, {'i', 's'}),
    ['<s-tab>'] = cmp.mapping(function (fallback)
      if ls.jumpable(-1) then
        ls.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),
    ]]--
    ['<c-p>'] = cmp.mapping.select_prev_item(),
    ['<c-n>'] = cmp.mapping.select_next_item(),
    ['<c-l>'] = cmp.mapping.complete(),
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
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'buffer', weight = 0.5 }
  })
}
