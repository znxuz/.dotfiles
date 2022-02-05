local cmp = require "cmp"
cmp.setup {
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		['<c-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
		['<c-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
		["<c-p>"] = cmp.mapping.select_prev_item(),
		["<c-n>"] = cmp.mapping.select_next_item(),
		["<c-l>"] = cmp.mapping.complete(),
		["<c-e>"] = cmp.mapping.close(),
		["<c-y>"] = cmp.mapping.confirm { select = true, },
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" , },
		{ name = "luasnip" , },
		{ name = "buffer", keyword_length = 3 },
	})
}
