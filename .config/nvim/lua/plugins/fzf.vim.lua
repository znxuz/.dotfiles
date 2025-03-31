return {
	'junegunn/fzf.vim',
	enabled = false,
	dependencies = 'junegunn/fzf',
	config = function ()
		vim.cmd [[
			let g:fzf_layout = { 'down': '10' }

			let g:fzf_vim = {}
			let g:fzf_vim.preview_window = ['hidden', 'ctrl-space']
			autocmd! FileType fzf set laststatus=0 noshowmode noruler
				\| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

			function! g:fzf_vim.listproc(list)
				call setqflist(a:list)
				cope
			endfunction
			function! s:build_quickfix_list(lines)
				call setqflist(map(copy(a:lines), '{ "filename": v:val, "lnum": 1 }'))
				cope
			endfunction

			let g:fzf_action = {
				\ 'ctrl-q': function('s:build_quickfix_list'),
				\ 'ctrl-t': 'tab split',
				\ 'ctrl-s': 'split',
				\ 'ctrl-v': 'vsplit' }
		]]
	end,
	keys = {
		{ '<leader>s', "<cmd>Files<cr>" },
		{ '<leader>b', "<cmd>Buffers<cr>" },
		{ '<leader>R',  "<cmd>Rg<cr>" },
		{ '<leader>h',  "<cmd>Helptags<cr>", },
		{ '<leader>k',  "<cmd>Maps<cr>", },
	}
}
