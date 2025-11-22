vim.keymap.set('n', '<leader>L', '<Cmd>Lazy<Cr>')

local FIND_CMD = 'ag --nocolor --just-filename -U -S -p $HOME/.config/fd/ignore -g'
local GREPPRG = 'ag --vimgrep --hidden -U -S -p $HOME/.config/fd/ignore'
local enable_fuzzy = function(s)
	return '"' .. s:gsub("^%*", ""):gsub(".", ".*%0") .. ".*" .. '"'
end

-- keymap for populating qf list without leaving the cmdline
vim.keymap.set('c', '<c-l>', function()
	local first_word = vim.fn.getcmdline():match('^(%S+)')
	if first_word == 'Find' or first_word == 'Buf' or first_word == 'Gr' then
		return '<cr>:<up>'
	else
		return '<c-l>'
	end
end, { expr = true })

-- find
function Find(arg, _)
	if arg:sub(1, 1) == "*" then arg = enable_fuzzy(arg) end
	return vim.fn.systemlist(FIND_CMD .. ' ' .. arg)
end

vim.api.nvim_create_user_command('Find', function(opts)
	vim.fn.setloclist(0, {}, 'r', {
		lines = Find(opts.args),
		efm = '%f',
		title = 'Search Results'
	})
	vim.cmd('lw')
end, { nargs = '+', complete = 'file' })
vim.opt.findfunc = "v:lua.Find"
vim.keymap.set("n", "gs", ":Find ")
vim.keymap.set("v", "gs", [["ty:Find t<cr>]])

-- buffer
vim.api.nvim_create_user_command('Buf', function(opts)
	if tonumber(opts.args) ~= nil then
		vim.cmd.buffer(opts.args)
		return
	end
	local buf_names = {}
	for buf in vim.iter(vim.api.nvim_list_bufs()):filter(vim.api.nvim_buf_is_loaded) do
		table.insert(buf_names, vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":~:."))
	end
	vim.fn.setloclist(0, {}, 'r', {
		lines = vim.fn.systemlist(FIND_CMD .. ' ' .. enable_fuzzy(opts.args), table.concat(buf_names, "\n")),
		efm = '%f',
		title = 'Search Results'
	})
	vim.cmd('lw')
end, { nargs = '+', complete = 'file' })
vim.keymap.set("n", "gb", '<cmd>ls<cr>:Buf ')

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
	vim.ui.input({ prompt = "> ", completion = "shellcmdline" }, function(c)
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
end, { silent = true })

-- toggle term
local term_name = "term://toggleterm"
local function toggleterm()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if string.find(vim.api.nvim_buf_get_name(buf), term_name) then
			vim.cmd("sb " .. buf)
			return
		end
	end
	vim.cmd.split()
	vim.cmd.term()
	vim.api.nvim_buf_set_name(0, term_name)
end
vim.keymap.set('n', '<A-enter>', function()
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win)):find(term_name) then
			vim.api.nvim_win_close(win, false)
			return
		end
	end
	toggleterm()
end)
vim.keymap.set('t', '<A-enter>', function()
	if vim.api.nvim_buf_get_name(0):find(term_name) then
		vim.cmd.close()
	end
end)
