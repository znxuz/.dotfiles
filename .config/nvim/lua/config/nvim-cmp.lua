local cmp = require 'cmp'
cmp.setup {
    mapping = {
	['<c-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
	['<c-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
	['<c-n>'] = cmp.mapping.select_next_item(),
	['<c-p>'] = cmp.mapping.select_prev_item(),
	['<c-l>'] = cmp.mapping.complete(),
	['<c-e>'] = cmp.mapping.close(),
    },
    sources = cmp.config.sources({
	{ name = 'nvim_lsp' },
	{ name = 'buffer', keyword_length = 3 },
    })
}
