local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local actions_layout = require('telescope.actions.layout')

telescope.setup {
	defaults = {
		layout_strategy = 'vertical',
		layout_config = {
			width = 0.7,
			height = 0.9,
		},
		borderchars = {'─', '│', '─', '│', '┌', '┐', '┘', '└'},
		preview = { hide_on_startup = true },
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<c-q>"] = actions.smart_send_to_qflist,
				["<c-s>"] = actions.select_horizontal,
				["<c-f>"] = actions_layout.toggle_preview,
			},
		},
		file_ignore_patterns = { ".git", ".cache" },
	},
	pickers = {
		find_files = {
			hidden = true,
			no_ignore = false,
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		}
	}
}
telescope.load_extension('fzf')

local M = {}

M.find_files_in = function()
	vim.ui.input({ prompt = 'Files in: ', completion = 'dir' }, function(input)
		if input ~= nil and input ~= '' then
			builtin.find_files({ cwd = input })
		end
	end)
end

M.live_grep_in = function()
	vim.ui.input({ prompt = 'Grep in: ', completion = 'dir' }, function(input)
		if input ~= nil and input ~= '' then
			builtin.live_grep({ cwd = input })
		end
	end)
end


local map = require("config.mapper").map
map('n', '<leader>f', function () builtin.find_files() end)
map('n', '<leader>cf', function () builtin.find_files({ cwd = vim.fn.expand('%:h') }) end)
map('n', '<leader>if', function () require'config.telescope'.find_files_in() end)
map('n', '<leader>b', function () builtin.buffers() end)
map('n', '<leader>ir', function () require'config.telescope'.live_grep_in() end)
map('n', '<leader>r', function () builtin.live_grep() end)
map('n', '<leader>h', function () builtin.help_tags() end)
map('n', '<leader>A', function () builtin.builtin() end)
map('n', '<leader>o', function () builtin.oldfiles() end)
map('n', '<leader>k', function () builtin.keymaps() end)

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(_)
		map('n', 'gd', function () builtin.lsp_definitions() end, { buffer = true })
		map('n', 'gD', function () builtin.lsp_type_definitions() end, { buffer = true })
		map('n', 'gr', function () builtin.lsp_references() end, { buffer = true })
		map('n', 'gI', function () builtin.lsp_implementations() end, { buffer = true })
		map('n', '<leader>aa', function () vim.lsp.buf.code_action() end, { buffer = true })
		map('n', '<leader>s', function () builtin.lsp_document_symbols() end, { buffer = true })
		map('n', '<leader>S', function () builtin.lsp_workspace_symbols() end, { buffer = true })
		map('n', '<leader>e', function () builtin.diagnostics({ bufnr = 0 }) end, { buffer = true })
		map('n', '<leader>E', function () builtin.diagnostics() end, { buffer = true })
	end,
})

return M
