local function is_loclist()
	return vim.fn.getwininfo(vim.fn.win_getid())[1]['loclist'] == 1
end

local function set_prev_win(prev_winid, cur_winid)
	vim.api.nvim_set_current_win(prev_winid)
	vim.api.nvim_set_current_win(cur_winid)
end

-- TODO: also open buf with restored cursor i.e. use `o` remapped keybind
local function split_open(new_win)
	local qf_line = vim.api.nvim_win_get_cursor(0)[1]
	local qf_open_close_cmds = is_loclist() and { 'll', 'lcl' } or { 'cc', 'ccl' }

	vim.cmd.wincmd('p')
	local win_id = vim.api.nvim_get_current_win()
	new_win()
	vim.cmd(qf_line .. qf_open_close_cmds[1])
	vim.api.nvim_win_call(win_id, function() vim.cmd(qf_open_close_cmds[2]) end)
end

-- vim.keymap.set('n', 'o', '<c-w>z<cr>', { buffer = true, silent = true })
vim.keymap.set('n', 'o', function()
	local prev_winid = vim.fn.win_getid(vim.fn.winnr('#'))
	local qfline = (is_loclist() and vim.fn.getloclist(0) or vim.fn.getqflist())[vim.api.nvim_win_get_cursor(0)[1]]

	vim.cmd.wincmd('z')
	if qfline.lnum == 0 and vim.api.nvim_win_is_valid(prev_winid) then
		-- vim.api.nvim_win_set_buf(prev_winid, qfline.bufnr) -- triggers hard error when a swap file is present
		vim.api.nvim_set_current_win(prev_winid)
		vim.cmd.buffer(qfline.bufnr)
		vim.bo.buflisted = true
	else
		vim.api.nvim_feedkeys(vim.keycode('<cr>'), 'ni', false) -- i flag somehow critical for this to work
	end
end
, { buffer = true, silent = true })
vim.keymap.set('n', '<cr>', 'o<c-w>p<c-w>c', { buffer = true, silent = true, remap = true })
vim.keymap.set('n', 'p', function()
	local center_win = function() vim.cmd('norm! zz') end
	local qf_winid = vim.api.nvim_get_current_win()
	local prev_winid = vim.fn.win_getid(vim.fn.winnr('#'))
	local qfline = (is_loclist() and vim.fn.getloclist(0) or vim.fn.getqflist())[vim.api.nvim_win_get_cursor(0)[1]]

	vim.cmd('pedit +' .. qfline.lnum .. ' ' .. vim.api.nvim_buf_get_name(qfline.bufnr))
	set_prev_win(prev_winid, qf_winid)
	require('pvw').run_in_pvw(center_win)
end, {
	buffer = true,
	silent = true,
	desc = 'Open quickfix entry in preview window'
})
vim.keymap.set('n', '<c-s>', function() split_open(vim.cmd.new) end, { buffer = true, silent = true })
vim.keymap.set('n', '<c-v>', function() split_open(vim.cmd.vnew) end, { buffer = true, silent = true, remap = true })
vim.keymap.set('n', '<c-t>', function() split_open(vim.cmd.tabnew) end, { buffer = true, silent = true, remap = true })

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
