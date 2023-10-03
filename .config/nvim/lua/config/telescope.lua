local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup {
  defaults = {
    border = false,
    prompt_prefix = " > ",
    preview = false,
    layout_strategy = "horizontal",
    layout_config = {
      prompt_position = "bottom",
      height = 0.8,
      width = 0.5,
    },
    sorting_strategy = "ascending",
    shorten_path = true,
    mappings = {
      i = {
	["<esc>"] = actions.close,
	["<c-s>"] = actions.select_horizontal,
        ["<C-u>"] = false,
      },
    },
  },
  pickers = {
    find_files = { hidden = true },
    file_browser = { hidden = true },
  },
  -- extensions = {
    -- fzf = {
      -- fuzzy = true,
      -- override_generic_sorter = true,
      -- override_file_sorter = true,
    -- }
  -- }
}
-- telescope.load_extension('fzf')

local M = {}

M.find_files_in = function()
  vim.ui.input({ prompt = 'Files in: ', completion = "file" }, function(input)
    if input ~= nil and input ~= '' then
      require('telescope.builtin').find_files({ cwd = input })
    end
  end)
end

M.live_grep_in = function()
  vim.ui.input({ prompt = 'Grep in: ', completion = "file" }, function(input)
    if input ~= nil and input ~= '' then
      require('telescope.builtin').live_grep({ cwd = input })
    end
  end)
end


local map = require("config.mapper").map
map('n', '<leader>p', '<cmd>Telescope find_files<cr>')
map('n', '<leader>ip', '<cmd>lua require"config.telescope".find_files_in()<cr>')
map('n', '<leader>b', '<cmd>Telescope buffers<cr>')
map('n', '<leader>ir', '<cmd>lua require"config.telescope".live_grep_in()<cr>')
map('n', '<leader>r', '<cmd>Telescope live_grep<cr>')
map('n', '<leader>h', '<cmd>Telescope help_tags<cr>')
map('n', '<leader>A', '<cmd>Telescope builtin<cr>')
map('n', '<leader>o', '<cmd>Telescope oldfiles<cr>')
map('n', '<leader>k', '<cmd>Telescope keymaps<cr>')

return M
