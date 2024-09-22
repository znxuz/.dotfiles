local cmp = require('cmp')
local ls = require("luasnip")
local MAX_LABEL_WIDTH = 40
local ELLIPSIS_CHAR = '…'
local compare = cmp.config.compare

cmp.setup {
	enabled = function()
		if vim.fn.bufname("%") == "[Command Line]" then
			return false
		elseif vim.api.nvim_get_option_value('buftype', { buf = 0 }) == 'prompt' then
			return false
		end
		return true
	end,
	preselect = cmp.PreselectMode.None,
	snippet = { expand = function(args) require 'luasnip'.lsp_expand(args.body) end, },
	sorting = {
		comparators = {
			compare.score, -- sources' priority probably
			compare.length,
			compare.exact,
			compare.locality,
			compare.recently_used,
			compare.kind,
			compare.order,
			compare.offset,
		},
	},
	mapping = {
		['<c-e>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
		['<c-y>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
		['<tab>'] = cmp.mapping.confirm({ select = true }),
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
		{ name = 'buffer' }
	})
}
