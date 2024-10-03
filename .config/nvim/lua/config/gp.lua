local map = require('config.mapper').map
local MAIN_MODE = 'tabnew'

require("gp").setup({
	openai_api_key = { "pass", "openai" },
	chat_confirm_delete = false,
	default_chat_agent = 'gpt-code',
	agents = {
		{
			provider = 'openai',
			name = "gpt-code",
			chat = true,
			command = false,
			model = { model = "gpt-4o-mini", temperature = 0.3, top_p = 0.2 },
			system_prompt = require("gp.defaults").code_system_prompt
		},
	}
})

map('n', '<leader>gn', '<cmd>GpChatNew ' .. MAIN_MODE .. '<cr>')
map('n', '<leader>gt', '<cmd>GpChatToggle ' .. MAIN_MODE .. '<cr>')
map('n', '<leader>gd', '<cmd>GpChatDelete<cr>')
map('n', '<leader>gf', '<cmd>GpChatFinder<cr>')
map({ 'n', 'v' }, '<leader>gp', "<cmd>'<,'>GpChatPaste " .. MAIN_MODE .. '<cr>')
