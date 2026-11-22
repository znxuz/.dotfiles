local util = require 'util'

vim.keymap.set('n', 'gL', '<cmd>Lazy<cr>')
vim.keymap.set('n', '<c-k>', '<cmd>Man<cr>')
vim.keymap.set('n', 'gl', function()
	util.open_or_focus_qflist(true)
end)
vim.keymap.set('n', 'go', function()
	util.open_or_focus_qflist(false)
end)

vim.keymap.set('n', 'g<tab>', '<c-w>g<tab>', {
	remap = true,
	silent = true,
	desc = "switch to previous tab"
})
vim.keymap.set('n', '<c-w>gt', function()
	pcall(vim.cmd, 'tabm +' .. vim.v.count1)
end, {
	silent = true,
	desc = "move tab to the right"
})
vim.keymap.set('n', '<c-w>gT', function()
	pcall(vim.cmd, 'tabm -' .. vim.v.count1)
end, {
	silent = true,
	desc = "move tab to the left"
})

vim.keymap.set('c', '<c-l>', function()
	local first_word = vim.fn.getcmdline():match('^(%S+)')
	if first_word == 'Find' or first_word == 'Buf' or first_word == 'Gr' then
		return '<cr>:<up>'
	else
		return '<c-l>'
	end
end, {
	expr = true,
	desc = "run the cmd without leaving the cmdline"
})

-- find
vim.api.nvim_create_user_command('Find', function(opts)
	local result = vim.iter(util.search.find_or_filter(opts.args))
			:map(util.shorten_path)
			:totable()
	local is_loc = true
	util.populate_loclist(result, opts.name)
	util.open_or_focus_qflist(is_loc)
end, {
	nargs = '+',
	complete = 'file'
})
vim.opt.findfunc = "v:lua.require('util').search.find"
vim.keymap.set("n", "gs", ":Find ")
vim.keymap.set("v", "gs", [["ty:Find t<cr>]])

-- buffer
vim.api.nvim_create_user_command('Buf', function(opts)
	local bufs = vim.iter(vim.api.nvim_list_bufs())
			:filter(function(b)
				return vim.fn.buflisted(b) == 1
				-- and vim.api.nvim_buf_is_loaded(b)
				-- and b ~= vim.api.nvim_get_current_buf()
			end)
			:totable()
	table.sort(bufs, function(a, b)
		return vim.fn.getbufinfo(a)[1].lastused > vim.fn.getbufinfo(b)[1].lastused
	end)
	local bufnames = vim.iter(bufs)
			:map(vim.api.nvim_buf_get_name)
			:filter(function(name) return name ~= '' end)
			:map(util.shorten_path)
			:totable()

	local result = string.len(opts.args) ~= 0 and
			util.search.find_or_filter(opts.args, nil, bufnames) or
			bufnames
	util.populate_loclist(result, opts.name, {
		show_modified = true,
		show_lastused = true
	})

	local bufnr = vim.fn.getloclist(0, { qfbufnr = 0 }).qfbufnr
	local is_loc = true
	util.open_or_focus_qflist(is_loc)

	-- TODO: refactor to make it the delete work as operator
	vim.keymap.set('n', 'dd', function()
		local list = vim.fn.getloclist(0)
		local row = vim.api.nvim_win_get_cursor(0)[1]
		vim.cmd('bw ' .. list[row].bufnr)
		table.remove(list, row)

		local filenames = vim.iter(list)
				:map(function(e) return util.shorten_path(vim.fn.bufname(e.bufnr)) end)
				:totable()
		util.populate_loclist(filenames, opts.name, {
			show_modified = true,
			show_lastused = true
		})
		if #filenames > 0 then
			vim.api.nvim_win_set_cursor(0, { math.min(row, #filenames), 0 })
		end
	end, { buffer = bufnr }) -- TODO: refactor to buf once ubuntu unstable supports
end, {
	nargs = '*',
	complete = 'file'
})
vim.keymap.set("n", "gb", '<cmd>Buf<cr>')

-- grep
vim.o.grepprg = util.search.constants.GREP_CMD
vim.o.grepformat = util.search.constants.GREP_EFM
vim.api.nvim_create_user_command('Gr', function(opts)
	local fargs = opts.fargs
	if opts.fargs[#fargs] then
		opts.fargs[#fargs] = util.search.try_enable_fuzzy(opts.fargs[#fargs])
	end
	vim.cmd.grep({
		args = fargs,
		bang = true,
		mods = { silent = true }
	})
	local is_loc = false
	util.open_or_focus_qflist(is_loc)
end, {
	nargs = '+',
	complete = 'file'
})
vim.keymap.set("n", "gp", ":Gr ")
vim.keymap.set("v", "gp", function()
	local function get_selection()
		local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
		return table.concat(lines, "\n")
	end
	vim.cmd.Gr({
		args = {
			'-F',
			'--multiline',
			'--',
			vim.fn.shellescape(get_selection()), -- search term must be at the end
		},
	})
end, { silent = true })

vim.keymap.set("n", "<leader><leader>", function()
	vim.ui.input({
		prompt = "> ",
		completion = "shellcmdline"
	}, function(cmd)
		util.run_shell_cmd(cmd)
	end)
end, { desc = "run shell cmd in scratch buffer" })

vim.keymap.set('n', 'g~', function()
	local word = vim.fn.expand('<cword>')
	if word == 'true' then
		vim.cmd('norm ciwfalse')
	elseif word == 'false' then
		vim.cmd('norm ciwtrue')
	end
end, {
	silent = true,
	desc = "toggle true/false under cursor"
})

-- toggle term
local term_name = "term://toggleterm"
local function get_term_win()
	return vim.iter(vim.api.nvim_tabpage_list_wins(0))
			:find(function(winid)
				return vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(winid)) == term_name
			end)
end
local function toggleterm()
	local function close_if_present()
		local term_winid = get_term_win()
		if term_winid then vim.api.nvim_win_close(term_winid, false) end
		return term_winid
	end
	local function open_if_buffered()
		local termbuf = vim.iter(vim.api.nvim_list_bufs())
				:map(vim.api.nvim_buf_get_name)
				:find(term_name)
		if termbuf then vim.cmd.sb(termbuf) end
		return termbuf
	end

	if close_if_present() or open_if_buffered() then
		return
	end
	vim.cmd.split()
	vim.cmd.term()
	vim.api.nvim_buf_set_name(0, term_name)
end
vim.keymap.set('n', '<A-enter>', toggleterm)
vim.keymap.set('t', '<A-enter>', toggleterm)

-- notification upon cmd finish `-h shell-prompt`
vim.api.nvim_create_autocmd('TermRequest', {
	group = vim.api.nvim_create_augroup("term_prompt_notification", {}),
	desc = 'Handles OSC 7 dir change requests',
	callback = function(ev)
		if get_term_win() then return end
		local row = ev.data.cursor[1]
		if row == 1 then return end
		vim.notify("command finished", vim.log.levels.INFO)
	end
})

vim.keymap.set("n", "<leader>k", function()
	local ms = tonumber(vim.fn.expand("<cword>"))
	if not ms then return end

	local sec, rem = math.floor(ms / 1000), ms % 1000
	local utc = os.date("!%Y-%m-%d %H:%M:%S", sec) .. string.format(".%03d UTC", rem)
	local cet = os.date("%Y-%m-%d %H:%M:%S", sec) .. string.format(".%03d %s", rem, os.date("%Z", sec))

	vim.lsp.util.open_floating_preview({ utc, cet }, "", { border = "single", focus_id = "unix_utc" })
end, { desc = "show ms Unix timestamp as UTC and MEWT/MEST" })
