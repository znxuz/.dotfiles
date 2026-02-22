return {
	'stevearc/oil.nvim',
	enabled = true,
	keys = { { '-', '<cmd>Oil<cr>', mode = 'n' } },
	init = function(p)
		-- see https://github.com/stevearc/oil.nvim/issues/300#issuecomment-1950541064
		if vim.fn.argc() == 1 then
			local argv = tostring(vim.fn.argv(0))
			local stat = vim.loop.fs_stat(argv)

			local remote_dir_args = vim.startswith(argv, "ssh") or
					vim.startswith(argv, "sftp") or
					vim.startswith(argv, "scp")

			if stat and stat.type == "directory" or remote_dir_args then
				require("lazy").load { plugins = { p.name } }
			end
		end
		if not require("lazy.core.config").plugins[p.name]._.loaded then
			vim.api.nvim_create_autocmd("BufNew", {
				callback = function(ev)
					if vim.fn.isdirectory(ev.file) == 1 then
						require("lazy").load { plugins = { "oil.nvim" } }
						return true -- once oil is loaded, we can delete this autocmd
					end
				end,
			})
		end
	end,
	config = function()
		local oil = require("oil")
		local actions = require("oil.actions")
		oil.setup({
			default_file_explorer = true, -- set false and then run `set spell` to let netrw download the spellfiles
			keymaps = {
				["gs"] = false,
				["<C-v>"] = { "actions.select", opts = { vertical = true } },
				["<C-s>"] = { "actions.select", opts = { horizontal = true } },
				["<C-p>"] = { "actions.preview", opts = { horizontal = true } },
				["<C-q>"] = function() actions.send_to_qflist.callback({ action = ' ', target = 'loclist' }) end,
			},
			preview_win = {
				update_on_cursor_moved = false,
				preview_method = "load"
			},
			view_options = { show_hidden = true },
			float = { border = 'single' },
			confirmation = { border = 'single' },
			progress = { border = 'single' },
			ssh = { border = "single" },
			keymaps_help = { border = "single" },
		})

		vim.cmd.cabbr({
			args = { "<expr>", "%", "&filetype == 'oil' ? bufname('%')[6:] : '%'" }
		})
	end
}
