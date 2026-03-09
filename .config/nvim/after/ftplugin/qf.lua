local function pvw_id()
	return vim.iter(vim.api.nvim_tabpage_list_wins(0))
			:find(function(v) return vim.api.nvim_get_option_value('pvw', { win = v }) end)
end

local function run_in_pvw(cmd_fn)
	local pvw_winid = pvw_id()
	if not pvw_winid then return nil end
	vim.api.nvim_win_call(pvw_winid, cmd_fn)
	vim.cmd('redraw!') -- cursor sometimes get stuck in pvw window, so force redraw
	return pvw_winid
end

vim.keymap.set('n', 'o', '<c-w>z<cr>', { buffer = true, silent = true })
vim.keymap.set('n', '<cr>', 'o<c-w>p<c-w>c', { buffer = true, silent = true, remap = true })
vim.keymap.set('n', 'p', function()
	local center_win = function() vim.cmd('norm! zz') end
	local qf_winid = vim.api.nvim_get_current_win()
	local prev_winid = vim.fn.win_getid(vim.fn.winnr('#'))
	local get_list = vim.fn.getwininfo(vim.fn.win_getid())[1]['loclist'] == 1
			and vim.fn.getloclist(0)
			or vim.fn.getqflist()
	local qfline = get_list[vim.fn.line('.')]

	vim.cmd('pedit +' .. qfline.lnum .. ' ' .. vim.api.nvim_buf_get_name(qfline.bufnr))
	if prev_winid ~= 0 then
		vim.api.nvim_set_current_win(prev_winid)
		vim.api.nvim_set_current_win(qf_winid)
	end
	run_in_pvw(center_win)
end, {
	buffer = true,
	silent = true,
	desc = 'Open quickfix entry in preview window'
})
vim.keymap.set('n', '<c-s>', '<c-w><cr><c-w>p<c-w>c', { buffer = true, silent = true })
vim.keymap.set('n', '<c-v>', '<c-s><c-w>H', { buffer = true, silent = true, remap = true })
vim.keymap.set('n', '<c-t>', '<c-s><c-w>T', { buffer = true, silent = true, remap = true })

-- scrolling, this was so unnecessarily difficult to figure out
vim.keymap.set('n', '<c-e>', function()
	local scroll_down = function() vim.cmd('norm! ') end
	if run_in_pvw(scroll_down) then return end
	scroll_down()
end, { buffer = true, silent = true })
vim.keymap.set('n', '<c-y>', function()
	local scroll_up = function() vim.cmd('norm! ') end
	if run_in_pvw(scroll_up) then return end
	scroll_up()
end, { buffer = true, silent = true })
vim.keymap.set('n', '<c-d>', function()
	local half_page_down = function() vim.cmd('norm! ') end
	if run_in_pvw(half_page_down) then return end
	half_page_down()
end, { buffer = true, silent = true })
vim.keymap.set('n', '<c-u>', function()
	local half_page_up = function() vim.cmd('norm! ') end
	if run_in_pvw(half_page_up) then return end
	half_page_up()
end, { buffer = true, silent = true })
vim.keymap.set('n', '<c-f>', function()
	local page_down = function() vim.cmd('norm! ') end
	if run_in_pvw(page_down) then return end
	page_down()
end, { buffer = true, silent = true })
vim.keymap.set('n', '<c-b>', function()
	local page_up = function() vim.cmd('norm! ') end
	if run_in_pvw(page_up) then return end
	page_up()
end, { buffer = true, silent = true })

vim.api.nvim_create_autocmd({ "WinClosed" }, {
	group = vim.api.nvim_create_augroup("qf", {}),
	callback = function(ev)
		if vim.api.nvim_get_option_value('buftype', { buf = ev.buf }) == 'quickfix' then
			vim.cmd.wincmd('z')
			if vim.fn.win_gettype(vim.fn.win_getid(vim.fn.winnr())) == 'quickfix' -- FIXME not for loclist
					and print(vim.fn.win_gettype(tonumber(ev.match))) ~= 'preview' then
				-- refocus the previous window (also paired with `p` mapping)
				-- can't use callback's ev because the cmd can't be run when qf is closed while
				-- not in focus
				vim.cmd.wincmd('p')
			end
		end
	end,
})
