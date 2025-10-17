vim.keymap.set('n', '<leader>L', '<Cmd>Lazy<Cr>')

local FD_CMD = 'fd --color=never --full-path --type file --hidden'
local GREPPRG = "rg -S --vimgrep -u --ignore-file=$HOME/.config/fd/ignore"

-- find

function Find(arg, _)
	if arg:sub(1, 1) == "*" then -- if first char is `*`, then fuzzy search
		arg = arg:gsub(".", ".*%0") .. ".*"
	end
	return vim.fn.systemlist(FD_CMD .. ' "' .. arg .. '"')
end

vim.opt.findfunc = "v:lua.Find"
vim.api.nvim_create_user_command('Find', function(opts)
	vim.fn.setqflist({}, 'r', {
		lines = Find(opts.args),
		efm = '%f',
		title = 'Search Results'
	})
	vim.cmd('cw')
end, { nargs = '+', complete = 'file' })
vim.keymap.set("n", "<leader>s", ":Find ")

-- grep

vim.o.grepprg = GREPPRG
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

-- true/false toggle

vim.keymap.set('n', 'gs', function()
	local word = vim.fn.expand('<cword>')
	if word == 'true' then
		vim.cmd('norm ciwfalse')
	elseif word == 'false' then
		vim.cmd('norm ciwtrue')
	end
end, { silent = false })
