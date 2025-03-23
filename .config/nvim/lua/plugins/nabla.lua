return {
	'jbyuki/nabla.nvim',
	dependencies = 'nvim-treesitter/nvim-treesitter',
	keys = {
		{ '<leader>np', function () require('nabla').popup() end },
		{ '<leader>nP', function () require('nabla').toggle_virt() end },
	},
	lazy = true
}
