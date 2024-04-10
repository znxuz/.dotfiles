local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup {
  defaults = {
    prompt_prefix = " > ",
    sorting_strategy = "ascending",
    mappings = {
      i = {
	["<esc>"] = actions.close,
	["<c-s>"] = actions.select_horizontal,
        ["<C-u>"] = false,
      },
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
  vim.ui.input({ prompt = 'Files in: ', completion = "dir" }, function(input)
    if input ~= nil and input ~= '' then
      require('telescope.builtin').find_files({ cwd = input })
    end
  end)
end

M.live_grep_in = function()
  vim.ui.input({ prompt = 'Grep in: ', completion = "dir" }, function(input)
    if input ~= nil and input ~= '' then
      require('telescope.builtin').live_grep({ cwd = input })
    end
  end)
end


local map = require("config.mapper").map
map('n', '<leader>f', '<cmd>Telescope find_files<cr>')
map('n', '<leader>cf', '<cmd>Telescope find_files %:h<cr>')
map('n', '<leader>if', function () require"config.telescope".find_files_in() end)
map('n', '<leader>b', '<cmd>Telescope buffers<cr>')
map('n', '<leader>ir', function () require"config.telescope".live_grep_in() end)
map('n', '<leader>r', '<cmd>Telescope live_grep<cr>')
map('n', '<leader>h', '<cmd>Telescope help_tags<cr>')
map('n', '<leader>A', '<cmd>Telescope builtin<cr>')
map('n', '<leader>o', '<cmd>Telescope oldfiles<cr>')
map('n', '<leader>k', '<cmd>Telescope keymaps<cr>')

return M
