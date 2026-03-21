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

-- scrolling, this was so unnecessarily difficult to figure out
vim.keymap.set('n', '<c-e>', function()
	local scroll_down = function() vim.cmd('norm! ') end
	if run_in_pvw(scroll_down) then return end
	scroll_down()
end, { silent = true })
vim.keymap.set('n', '<c-y>', function()
	local scroll_up = function() vim.cmd('norm! ') end
	if run_in_pvw(scroll_up) then return end
	scroll_up()
end, { silent = true })
vim.keymap.set('n', '<c-d>', function()
	local half_page_down = function() vim.cmd('norm! ') end
	if run_in_pvw(half_page_down) then return end
	half_page_down()
end, { silent = true })
vim.keymap.set('n', '<c-u>', function()
	local half_page_up = function() vim.cmd('norm! ') end
	if run_in_pvw(half_page_up) then return end
	half_page_up()
end, { silent = true })
vim.keymap.set('n', '<c-f>', function()
	local page_down = function() vim.cmd('norm! ') end
	if run_in_pvw(page_down) then return end
	page_down()
end, { silent = true })
vim.keymap.set('n', '<c-b>', function()
	local page_up = function() vim.cmd('norm! ') end
	if run_in_pvw(page_up) then return end
	page_up()
end, { silent = true })

return {
	pvw_id = pvw_id,
	run_in_pvw = run_in_pvw
}
