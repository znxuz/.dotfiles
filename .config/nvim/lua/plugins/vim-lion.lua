return {
	'tommcdo/vim-lion',
	init = function() vim.g.lion_squeeze_spaces = 1 end,
	keys = {
		{ 'gl', mode = 'n' },
		{ 'gL', mode = 'n' },
	}
}
