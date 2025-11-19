vim.keymap.set('n', 'o', '<c-w>z<cr>', { buffer = true, silent = true })
vim.keymap.set('n', '<cr>', 'o<c-w>p<c-w>c', { buffer = true, silent = true, remap = true })
vim.keymap.set('n', 'p', function()
	local cur_entry = vim.fn.getqflist()[vim.fn.line('.')]
	local filename = vim.fn.split(vim.fn.getline('.'), '|')[1]
	vim.cmd('pedit +' .. cur_entry.lnum .. ' ' .. filename)
end, {
	buffer = true,
	silent = true,
	desc = 'Open quickfix entry in preview'
})
