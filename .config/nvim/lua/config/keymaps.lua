vim.keymap.set('n', '<leader>L', '<Cmd>Lazy<Cr>')

local FD_CMD = 'fd --color=never --full-path --type file --hidden '

-- find
function Fd(file_pattern, _)
	-- if first char is * then fuzzy search
	if file_pattern:sub(1, 1) == "*" then
		file_pattern = file_pattern:gsub(".", ".*%0") .. ".*"
	end
	return vim.fn.systemlist(FD_CMD .. '"' .. file_pattern .. '"')
end
vim.opt.findfunc = "v:lua.Fd"

-- find multiple
vim.api.nvim_create_user_command('Fd', function(opts)
	vim.fn.setloclist(0, {}, 'r', {
		lines = vim.fn.systemlist(FD_CMD .. opts.args),
		efm = '%f',
		title = 'Search Results'
	})
	vim.cmd('lw')
end, { nargs = '+', complete = 'file' })
vim.keymap.set("n", "<leader>s", ":Fd ")

-- grep
vim.api.nvim_create_user_command('Gr', function(opts)
	vim.cmd('sil gr! ' .. opts.args)
	vim.cmd('cw')
end, { nargs = '+', complete = 'file' })
vim.keymap.set("n", "<leader>r", ":Gr ")

-- shell cmd
vim.keymap.set("n", "<leader><leader>", function()
	vim.ui.input({ prompt = "> " }, function(c)
		if c and c ~= "" then
			vim.cmd("nos enew")
			vim.bo.buftype = "nofile"
			vim.bo.bufhidden = "wipe"
			vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.systemlist(c))
		end
	end)
end)
