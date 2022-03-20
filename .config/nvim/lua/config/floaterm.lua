local map = require('config.utils').map

vim.g['floaterm_width'] = 0.75
vim.g['floaterm_height'] = 0.75
vim.g['autoclose'] = 2

map('n', '<m-cr>', '<cmd>FloatermToggle<cr>')
map('t', '<m-cr>', '<cmd>FloatermToggle<cr>')

local function search_cppman(input)
	local cmd = 'FloatermNew --disposable --autoclose=2 ' ..
	'--width=1.0 --height=1.0 cppman ' .. input
	vim.cmd(cmd)
end

local M = {}

M.search_cppman_cursor = function ()
	local word = vim.fn.expand('<cword>')
	if word ~= '' then
		search_cppman(word)
	end
end

M.search_cppman_prompt = function ()
	vim.ui.input( { prompt = 'cppman: ' }, function(input)
		if input == nil or input == '' then
			return
		end
		search_cppman(input)
	end)
end

map('n', '<leader><c-k>', '<cmd>lua require("config.floaterm").search_cppman_cursor()<cr>')
map('n', '<m-k>', '<cmd>lua require("config.floaterm").search_cppman_prompt()<cr>')

return M
