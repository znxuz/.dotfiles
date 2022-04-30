local telescope = require('telescope')
local actions = require('telescope.actions')
telescope.setup {
    defaults = {
	prompt_prefix = " ❯ ",
	layout_config = { prompt_position = "top", },
	sorting_strategy = "ascending",
	file_sorter = require('telescope.sorters').get_fzy_sorter,
	file_ignore_patterns = {".git/", ".cache", "%.o", "%.a", "%.out", "%.class",
	"%.pdf", "%.mkv", "%.mp4", "%.zip"},
	shorten_path = false,
	mappings = {
	    i = {
		["<esc>"] = actions.close,
		["<c-s>"] = actions.select_horizontal,
	    },
	},
    },
    pickers = {
	find_files = { hidden = true, no_ignore = true, },
	file_browser = { hidden = true, no_ignore = true, },
    },
    extensions = {
	fzf = {
	    fuzzy = true,
	    override_generic_sorter = true,
	    override_file_sorter = true,
	}
    }
}
telescope.load_extension('fzf')

local map = require("config.utils").map
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
map('n', '<leader>fa', '<cmd>Telescope find_files search_dirs=~<cr>')
map('n', '<leader>fc', '<cmd>Telescope find_files search_dirs=%:p:h<cr>')
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
map('n', '<leader>fr', '<cmd>Telescope resume<cr>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
map('n', '<leader>ft', '<cmd>Telescope builtin<cr>')
map('n', '<leader>fj', '<cmd>Telescope jumplist<cr>')
map('n', '<leader>fo', '<cmd>Telescope oldfiles<cr>')
map('n', '<leader>fm', '<cmd>Telescope keymaps<cr>')
map('n', '<leader>fq', '<cmd>Telescope quickfix<cr>')
