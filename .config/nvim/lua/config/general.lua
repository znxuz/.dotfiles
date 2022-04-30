local map = require('config.utils').map

local M = {}

local function search_cppman(search_term)
    local cmd = 'tmux splitw -b "cppman ' .. search_term .. '"'
    vim.fn.system(cmd)
end

M.search_cppman_cursor = function ()
    local search_term = vim.fn.expand('<cword>')
    if search_term ~= '' then
	search_cppman(search_term)
    end
end

M.search_cppman_prompt = function ()
    vim.ui.input( { prompt = 'cppman: ' }, function(search_term)
	if search_term == nil or search_term == '' then
	    return
	end
	search_cppman(search_term)
    end)
end

map('n', '<leader><c-k>', '<cmd>lua require("config.general").search_cppman_cursor()<cr>')
map('n', '<m-k>', '<cmd>lua require("config.general").search_cppman_prompt()<cr>')

return M
