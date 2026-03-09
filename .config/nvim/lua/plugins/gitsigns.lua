local map_prefix = "<leader>g"

return {
	'lewis6991/gitsigns.nvim',
	config = true,
	keys = {
		{ map_prefix .. 'b', "<cmd>Gitsigns blame_line<cr>",                      mode = "n" },
		{ map_prefix .. 'B', "<cmd>Gitsigns blame<cr>",                           mode = "n" },
		{ map_prefix .. 'd', function() require('gitsigns').diffthis() end,       mode = "n" },
		{ map_prefix .. 'D', function() require('gitsigns').diffthis('@') end,    mode = "n" },
		{ map_prefix .. 'c', function() require('gitsigns').setqflist() end,      mode = "n" },
		{ map_prefix .. 'C', function() require('gitsigns').setqflist("all") end, mode = "n" },
		{ map_prefix .. 'r', function() require('gitsigns').reset_hunk() end,     mode = 'n' },
		{ map_prefix .. 'R', function() require('gitsigns').reset_buffer() end,   mode = 'n' },
		{ map_prefix .. 'a', function() require('gitsigns').stage_hunk() end,     mode = 'n' },
		{ map_prefix .. 'A', function() require('gitsigns').stage_buffer() end,   mode = 'n' },
		{
			"]c",
			function()
				if not vim.wo.diff then
					require('gitsigns').nav_hunk('next', { target = "all" }); do return end
				end
				vim.cmd('norm! ]c')
			end,
			mode = "n"
		},
		{
			"[c",
			function()
				if not vim.wo.diff then
					require('gitsigns').nav_hunk('prev', { target = "all" }); do return end
				end
				vim.cmd('norm! [c')
			end,
			mode = "n"
		},
		{
			"]C",
			function()
				if not vim.wo.diff then
					require('gitsigns').nav_hunk('last', { target = "all" }); do return end
				end
				vim.cmd('norm! ]c')
			end,
			mode = "n"
		},
		{
			"[C",
			function()
				if not vim.wo.diff then
					require('gitsigns').nav_hunk('first', { target = "all" }); do return end
				end
				vim.cmd('norm! [c')
			end,
			mode = "n"
		}
	},
	event = "VeryLazy"
}
