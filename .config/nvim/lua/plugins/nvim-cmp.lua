local config = function()
	local cmp = require('cmp')
	local luasnip = require('luasnip')
	local MAX_LABEL_WIDTH = 40
	local ELLIPSIS_CHAR = '…'

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
		completion = { completeopt = table.concat(vim.opt.completeopt:get(), ',') },
		snippet = { expand = function(args) require 'luasnip'.lsp_expand(args.body) end },
		sorting = {
			comparators = {
				cmp.config.compare.score, -- sources' priority probably
				cmp.config.compare.length,
				cmp.config.compare.exact,
				cmp.config.compare.locality,
				cmp.config.compare.recently_used,
				cmp.config.compare.kind,
				cmp.config.compare.order,
				cmp.config.compare.offset,
			},
		},
		mapping = {
			['<c-e>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i' }),
			['<c-y>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i' }),
			['<enter>'] = cmp.mapping.confirm(),
			["<tab>"] = cmp.mapping(function(fallback)
				if luasnip.jumpable() then
					luasnip.jump(1)
				elseif cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end, { "i", "s" }
			),
			["<s-tab>"] = cmp.mapping(function(fallback)
				if luasnip.jumpable() then
					luasnip.jump(-1)
				elseif cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end, { "i", "s" }
			),
			['<c-p>'] = cmp.mapping.select_prev_item(),
			['<c-n>'] = cmp.mapping.select_next_item(),
			['<c-l>'] = cmp.mapping.complete(),
			['<c-h>'] = cmp.mapping.abort(),
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
end

return {
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			{
				'L3MON4D3/LuaSnip',
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load({ paths = "./snippets" })
				end
			},
			'saadparwaiz1/cmp_luasnip',
		},
		config = config,
		event = "InsertEnter",
	},
}
