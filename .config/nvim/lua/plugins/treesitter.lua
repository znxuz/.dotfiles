return {
	'nvim-treesitter/nvim-treesitter',
	branch = 'main',
	build = ':TSUpdate',
	lazy = false,
	config = function()
		require('nvim-treesitter').install {
			'markdown',
			'vimdoc',
			'c',
			'cpp',
			'lua',
			'bash',
			'rust',
			'vim',
			'query',
			'latex', -- binary in package `treesitter-cli` in PATH needed
			'toml',
			'comment',
			'yaml',
		}
		-- syntax highlighting
		vim.api.nvim_create_autocmd('FileType', {
			callback = function()
				pcall(vim.treesitter.start)
			end
		})
	end
}
