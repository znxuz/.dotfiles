return {
	"andrewferrier/debugprint.nvim",
	config = true,
	event = "VeryLazy",
	keys = {
		{ 'g??', '<cmd>Debugprint resetcounter<cr>', 'n' },
		{ 'g?d', '<cmd>Debugprint delete<cr>', 'n' },
		{ 'g?c', '<cmd>Debugprint qflist<cr>', 'n' },
		{ 'g?gc', '<cmd>Debugprint commenttoggle<cr>', 'n' }
	}
}
