local MAIN_MODE = 'tabnew'

local config = function()
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
end

return {
	{
		"robitx/gp.nvim",
		config = config,
		keys = {
			{ '<leader>gn', '<cmd>GpChatNew ' .. MAIN_MODE .. '<cr>' },
			{ '<leader>gt', '<cmd>GpChatToggle ' .. MAIN_MODE .. '<cr>' },
			{ '<leader>gd', '<cmd>GpChatDelete<cr>' },
			{ '<leader>gf', '<cmd>GpChatFinder<cr>' },
			{ '<leader>gp', ":<c-u>'<,'>GpChatPaste " .. MAIN_MODE .. '<cr>', mode = 'v' } -- has to be :<c-u>'<,'>
		},
		enabled = false,
	},
}
