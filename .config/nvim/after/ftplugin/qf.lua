local util = require 'util'

local function set_prev_win(prev_winid, cur_winid)
	vim.api.nvim_set_current_win(prev_winid)
	vim.api.nvim_set_current_win(cur_winid)
end

-- avoid default keybind for open in case the entry doesn't have an associated line number,
-- so that cursor would always be positioned at the top of the file when selecting the entry
-- using default keybind in qf
local function open(close, prev_winid)
	local qf_win = vim.api.nvim_get_current_win()
	local row = vim.api.nvim_win_get_cursor(0)[1]
	local qfline = (util.is_loc() and vim.fn.getloclist(0) or vim.fn.getqflist())[row]
	local qf_cmd = util.is_loc() and 'll' or 'cc'
	prev_winid = prev_winid or vim.fn.win_getid(vim.fn.winnr('#'))

	vim.cmd.wincmd('z')

	if qfline.lnum == 0 then
		vim.api.nvim_win_call(prev_winid, function()
			vim.cmd.buffer(qfline.bufnr)
			vim.bo.buflisted = true
		end)
	else
		vim.api.nvim_win_call(prev_winid, function() vim.cmd(row .. qf_cmd) end) -- in case prev_win is a new tabpage
		-- vim.api.nvim_feedkeys(vim.keycode('<cr>'), 'ni', false) -- i flag somehow critical for this to work
	end

	if close then
		pcall(vim.api.nvim_win_close, qf_win, false) -- would throw err if qf_win became the last/only win upon closing
	end
	vim.api.nvim_set_current_win(prev_winid) -- explicitly switch in case of a new tabpage
end

local function split_open(new_win)
	local qf_win = vim.api.nvim_get_current_win()
	vim.api.nvim_set_current_win(vim.fn.win_getid(vim.fn.winnr('#')))
	new_win()
	local winid = vim.api.nvim_get_current_win()
	vim.api.nvim_set_current_win(qf_win)
	open(true, winid)
end

vim.keymap.set('n', 'o', open, { buffer = true, silent = true })
vim.keymap.set('n', '<cr>', function() open(true) end, { buffer = true, silent = true, remap = true })
vim.keymap.set('n', '<c-s>', function() split_open(vim.cmd.sp) end, { buffer = true, silent = true })
vim.keymap.set('n', '<c-v>', function() split_open(vim.cmd.vsp) end, { buffer = true, silent = true, remap = true })
vim.keymap.set('n', '<c-t>', function() split_open(function () vim.cmd('tab split') end) end, { buffer = true, silent = true, remap = true })
vim.keymap.set('n', 'p', function()
	local center_win = function() vim.cmd('norm! zz') end
	local qf_winid = vim.api.nvim_get_current_win()
	local prev_winid = vim.fn.win_getid(vim.fn.winnr('#'))
	local qfline = (util.is_loc() and vim.fn.getloclist(0) or vim.fn.getqflist())[vim.api.nvim_win_get_cursor(0)[1]]

	vim.cmd('pedit +' .. qfline.lnum .. ' ' .. vim.api.nvim_buf_get_name(qfline.bufnr))
	set_prev_win(prev_winid, qf_winid)
	require('pvw').run_in_pvw(center_win)
end, {
	buffer = true,
	silent = true,
	desc = 'Open quickfix entry in preview window'
})
vim.keymap.set('n', '{', function()
	local prev = util.is_loc() and vim.cmd.lol or vim.cmd.col
	pcall(prev)
end, { buffer = true, silent = true })
vim.keymap.set('n', '}', function()
	local next = util.is_loc() and vim.cmd.lnew or vim.cmd.cnew
	pcall(next)
end, { buffer = true, silent = true })

vim.api.nvim_create_autocmd({ "WinClosed" }, {
	group = vim.api.nvim_create_augroup("qf", {}),
	callback = function(ev)
		if vim.api.nvim_get_option_value('buftype', { buf = ev.buf }) == 'quickfix' then
			vim.cmd.wincmd('z')
			local wintype = vim.fn.win_gettype(vim.fn.win_getid(vim.fn.winnr()))
			if (wintype == 'quickfix' or wintype == 'loclist')
					and vim.fn.win_gettype(tonumber(ev.match)) ~= 'preview' then
				-- last win_gettype() condition necessary: when the cursor is on
				-- quickfix/loclist and ctrl-w_z closing the preview window, the
				-- wincmd('p') below shall not be triggered.
				vim.cmd.wincmd('p')
			end
		end
	end,
})

vim.keymap.set('n', 'i', function()
	local winid = vim.api.nvim_get_current_win()
	local is_loc = util.is_loc(winid)
	local items = is_loc and vim.fn.getloclist(winid) or vim.fn.getqflist()
	local list = vim.iter(items):map(function(item)
		local fname = item.bufnr > 0 and util.shorten_path(vim.fn.bufname(item.bufnr)) or ''
		if item.text == '' then return fname end
		if fname == '' then return item.text end
		return item.lnum > 0
				and string.format('%s:%d:%d:%s', fname, item.lnum, item.col, item.text)
				or string.format('%s:%s', fname, item.text)
	end):totable()
	local function update(action, lines)
		if is_loc then
			util.populate_loclist(lines, 'Filtered Results', {
				action = action,
				winid = winid,
			})
		else
			vim.fn.setqflist({}, action, { lines = lines, title = 'Filtered Results' })
		end
	end

	update(' ', list)

	local id = vim.api.nvim_create_autocmd('CmdlineChanged', {
		nested = true,
		callback = function()
			local pat = vim.fn.getcmdline()
			local filtered = pat == '' and list or util.search.find_or_filter(pat, nil, list)
			update('r', filtered)
			vim.cmd.redraw()
		end,
	})

	vim.ui.input({ prompt = 'Filter: ' }, function(input)
		vim.api.nvim_del_autocmd(id)
		if not input or input == '' then
			vim.cmd(is_loc and 'silent! lolder' or 'silent! colder')
		end
	end)
end, { buffer = true, silent = true, desc = "dynamic fuzzy filter" })
