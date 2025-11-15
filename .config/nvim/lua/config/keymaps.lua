vim.keymap.set('n', '<leader>L', '<Cmd>Lazy<Cr>')

local FD_CMD = 'fd --color=never --full-path --type file -u --ignore-file $HOME/.config/fd/ignore'
local GREPPRG = "rg -S --vimgrep -uu --ignore-file=$HOME/.config/fd/ignore"

-- keymap for populating qf list without leaving the cmdline

vim.keymap.set('c', '<c-l>', function()
	local first_word = vim.fn.getcmdline():match('^(%S+)')
	if first_word == 'Find' or first_word == 'Gr' then
		return '<cr>:<up>'
	else
		return '<c-l>'
	end
end, { expr = true })

-- find

function Find(arg, _)
	local enable_fuzzy = function(s) return '"' .. s:gsub(".", ".*%0") .. ".*" .. '"' end
	if arg:sub(1, 1) == "*" then
		arg = enable_fuzzy(arg)
	end
	return vim.fn.systemlist(FD_CMD .. ' ' .. arg)
end

vim.opt.findfunc = "v:lua.Find"
vim.api.nvim_create_user_command('Find', function(opts)
	vim.fn.setloclist(0, {}, 'r', {
		lines = Find(opts.args),
		efm = '%f',
		title = 'Search Results'
	})
	vim.cmd('lw')
end, { nargs = '+', complete = 'file' })
vim.keymap.set("n", "gs", ":Find ")
vim.keymap.set("v", "gs", [["ty:Find t<cr>]])

-- buffer

-- grep

vim.o.grepprg = GREPPRG
vim.api.nvim_create_user_command('Gr', function(opts)
	vim.cmd('sil gr! ' .. opts.args)
	vim.cmd('cw')
end, { nargs = '+', complete = 'file' })
vim.keymap.set("n", "gp", ":Gr ")
vim.keymap.set("v", "gp", [["ty:Gr 't'<cr>]])

-- shell cmd

vim.keymap.set("n", "<leader><leader>", function()
	vim.ui.input({ prompt = "> " }, function(c)
		if c and c ~= "" then
			vim.cmd("nos enew")
			vim.bo.buftype = "nofile"
			vim.bo.bufhidden = "wipe"
			vim.bo.filetype = "compiler" -- depends on syntax/compiler.vim
			vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.systemlist(c))
		end
	end)
end)

-- true/false toggle

vim.keymap.set('n', 'g~', function()
	local word = vim.fn.expand('<cword>')
	if word == 'true' then
		vim.cmd('norm ciwfalse')
	elseif word == 'false' then
		vim.cmd('norm ciwtrue')
	end
end, { silent = false })
