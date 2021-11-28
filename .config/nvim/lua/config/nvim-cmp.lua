local cmp = require "cmp"

cmp.setup {
	snippet = {
		expand = function(args)
		require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-l>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<C-y>"] = cmp.mapping.confirm { select = true, },
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "buffer", keyword_length = 3 },
		{ name = "luasnip" },
	})
}
