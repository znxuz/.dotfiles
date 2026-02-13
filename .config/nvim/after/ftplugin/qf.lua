local function run_in_pvw(cmd_fn)
	vim.cmd.wincmd('P')
	cmd_fn()
	vim.cmd.wincmd('p')
end

vim.keymap.set('n', 'o', '<c-w>z<cr>', { buffer = true, silent = true })
vim.keymap.set('n', '<cr>', 'o<c-w>p<c-w>c<c-w>p', { buffer = true, silent = true, remap = true }) -- an extra <c-w>p to return to the correct window
vim.keymap.set('n', 'p', function()
	local get_list = vim.fn.getwininfo(vim.fn.win_getid())[1]['loclist'] == 1
			and vim.fn.getloclist(0)
			or vim.fn.getqflist()
	local filename = vim.fn.split(vim.fn.getline('.'), '|')[1]
	vim.cmd('pedit +' .. get_list[vim.fn.line('.')].lnum .. ' ' .. filename)
	run_in_pvw(function() vim.cmd('norm! zz') end)
end, {
	buffer = true,
	silent = true,
	desc = 'Open quickfix entry in preview window'
})

vim.keymap.set('n', '<c-s>', '<c-w><cr><c-w>p<c-w>c', { buffer = true, silent = true })
vim.keymap.set('n', '<c-v>', '<c-s><c-w>H', { buffer = true, silent = true, remap = true })
vim.keymap.set('n', '<c-t>', '<c-s><c-w>T', { buffer = true, silent = true, remap = true })

-- scrolling, this was so unnecessarily difficult to figure out
vim.keymap.set('n', '<a-e>', function()
	run_in_pvw(function ()
		vim.api.nvim_win_call(vim.api.nvim_get_current_win(), function() vim.cmd([[normal! ]]) end)
	end)
end, { buffer = true, silent = true })
vim.keymap.set('n', '<a-y>', function()
	run_in_pvw(function ()
		vim.api.nvim_win_call(vim.api.nvim_get_current_win(), function() vim.cmd([[normal! ]]) end)
	end)
end, { buffer = true, silent = true })
vim.keymap.set('n', '<a-d>', function()
	run_in_pvw(function ()
		vim.api.nvim_win_call(vim.api.nvim_get_current_win(), function() vim.cmd([[normal! ]]) end)
	end)
end, { buffer = true, silent = true })
vim.keymap.set('n', '<a-u>', function()
	run_in_pvw(function ()
		vim.api.nvim_win_call(vim.api.nvim_get_current_win(), function() vim.cmd([[normal! ]]) end)
	end)
end, { buffer = true, silent = true })

-- maybe change event to when qf is out of focus
vim.api.nvim_create_autocmd({ "WinClosed" }, {
	group = vim.api.nvim_create_augroup("qf", {}),
	callback = function(ev)
		if vim.api.nvim_get_option_value('buftype', { buf = ev.buf }) == 'quickfix' then
			vim.cmd.wincmd('z')
		end
	end,
})

-- TODO dim the bg of PVW?
