return {
	'nvim-treesitter/nvim-treesitter-context',
	dependencies = 'nvim-treesitter/nvim-treesitter',
	enabled = true,
	config = function()
		require 'treesitter-context'.setup {
			multiwindow = true,
			max_lines = 1,
			line_numbers = true,
			multiline_threshold = 1,
			trim_scope = 'inner',
			mode = 'cursor',
			separator = '┄', -- ─
			zindex = 20,
			on_attach = nil,
		}
		vim.keymap.set('n', 'grc', '<cmd>TSContext toggle<cr>')

		-- enable vim regex-based syntax highlighting
		local render = require('treesitter-context.render')
		local open = render.open
		render.open = function(winid, ...)
			open(winid, ...)
			local ft = vim.bo[vim.api.nvim_win_get_buf(winid)].filetype
			if ft == '' then return end
			for _, win in ipairs(vim.api.nvim_list_wins()) do
				if vim.w[win].treesitter_context then
					local b = vim.api.nvim_win_get_buf(win)
					if vim.bo[b].syntax ~= ft then vim.bo[b].syntax = ft end
				end
			end
		end
	end
}
