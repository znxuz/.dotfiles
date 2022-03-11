local map = require('config.utils').map

map('n', '<leader><c-k>', ':call Dasht(dasht#cursor_search_terms())<cr>')
map('v', '<leader><c-K>', 'y:<c-u>call Dasht(getreg(0))<cr>')


vim.cmd [[
	let g:dasht_filetype_docsets = {}
	let g:dasht_filetype_docsets['cpp'] = ['c++']
]]
