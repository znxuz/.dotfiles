local cmp = require "cmp"

cmp.setup {
	snippet = {
		expand = function(args)
		require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		['<c-d>'] = cmp.mapping(cmp.mapping.scroll_docs(5), { 'i', 'c' }),
		['<c-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-5), { 'i', 'c' }),
		["<c-p>"] = cmp.mapping.select_prev_item(),
		["<c-n>"] = cmp.mapping.select_next_item(),
		["<c-l>"] = cmp.mapping.complete(),
		["<c-e>"] = cmp.mapping.close(),
		["<c-y>"] = cmp.mapping.confirm { select = true, },
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "buffer", keyword_length = 3 },
		{ name = "luasnip" },
	})
}
