local MAIN_MODE = 'popup'

local config = function()
	require("gp").setup({
		openai_api_key = { "pass", "openai" },
		chat_free_cursor = true,
		chat_confirm_delete = false,

		default_chat_agent = 'gpt-code',
		agents = {
			{
				provider = 'openai',
				name = "gpt-code",
				chat = true,
				command = false,
				model = {
					model = "gpt-4o-mini",
					temperature = 0.2,
					top_p = 0.4,
				},
				system_prompt = require("gp.defaults").chat_system_prompt
			},
		}
	})
end

return {
	{
		"robitx/gp.nvim",
		config = config,
		keys = {
			-- has to be :<c-u>'<,'> for selecting
			{ '<leader>gn', '<cmd>GpChatNew ' .. MAIN_MODE .. '<cr>' },
			{ '<leader>gg', '<cmd>GpChatToggle ' .. MAIN_MODE .. '<cr>' },
			{ '<leader>gf', '<cmd>GpChatFinder<cr>' },
			{ '<leader>gn', ":<c-u>'<,'>GpChatNew " .. MAIN_MODE .. '<cr>', mode = 'v' },
			{ '<leader>gg', ":<c-u>'<,'>GpChatToggle " .. MAIN_MODE .. '<cr>', mode = 'v' },
			{ '<leader>gp', ":<c-u>'<,'>GpChatPaste " .. MAIN_MODE .. '<cr>', mode = 'v' }
		},
		enabled = true,
	},
}
