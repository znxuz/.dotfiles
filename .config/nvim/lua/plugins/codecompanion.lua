local autocmd_group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

vim.api.nvim_create_autocmd({ "User" }, {
	pattern = "CodeCompanionRequestStarted",
	group = autocmd_group,
	callback = function(request)
		if request.data.strategy == "chat" then
			vim.api.nvim_feedkeys('G', 'n', false)
			vim.api.nvim_feedkeys('zt', 'n', false)
		end
	end,
})

vim.api.nvim_create_autocmd({ "User" }, {
	pattern = "CodeCompanionRequestStreaming",
	group = autocmd_group,
	callback = function(request)
		if request.data.strategy == "chat" then
			local timer = vim.uv.new_timer()
			timer:start(1000, 0, vim.schedule_wrap(function()
				vim.api.nvim_feedkeys('H', 'n', false)
				timer:stop()
				timer:close()
			end))
		end
	end,
})

return {
	"olimorris/codecompanion.nvim",
	enabled = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter"
	},
	opts = {
		display = {
			chat = {
				window = {
					title = "",
					layout = "float",
					border = "single",
					height = 0.9,
					width = 0.9,
					opts = {
						cursorline = true,
						spell = true,
					}
				},
				intro_message = "",
				show_settings = true
			},
		},
		strategies = {
			inline = { adapter = "deepseek_v3" },
			chat = {
				adapter = "deepseek_v3",
				keymaps = { options = { modes = { n = "g?" } } },
				roles = {
					llm = function(adapter) return adapter.formatted_name end,
					user = "Me",
				}
			}
		},
		adapters = {
			openai = function()
				return require("codecompanion.adapters").extend("openai", {
					env = { api_key = "cmd: pass openai" },
					schema = {
						model = { default = "gpt-4o" },
						temperature = { default = 0.1 },
						top_p = { default = 0.4 },
					},
				})
			end,
			deepseek_v3 = function()
				return require("codecompanion.adapters").extend("deepseek", {
					name = "DeepSeek-v3",
					env = { api_key = "cmd: pass openrouter" },
					url = "https://openrouter.ai/api/v1/chat/completions",
					schema = {
						model = { default = "deepseek/deepseek-chat" },
						temperature = { default = 0.1 },
						top_p = { default = 0.4 },
					}
				})
			end,
			deepseek_r1 = function()
				return require("codecompanion.adapters").extend("deepseek", {
					name = "DeepSeek-r1",
					env = { api_key = "cmd: pass openrouter" },
					url = "https://openrouter.ai/api/v1/chat/completions",
					schema = {
						model = { default = "deepseek/deepseek-r1" },
						temperature = { default = 0.1 },
						top_p = { default = 0.4 },
					}
				})
			end,
		},
	},
	keys = {
		{ "<leader>G",  "<cmd>CodeCompanionActions<cr>",     mode = { "n", "v" }, desc = "CodeCompanion Actions" },
		{ "<leader>gg", "<cmd>CodeCompanionChat Toggle<cr>", mode = "n",          desc = "CodeCompanionChat Toggle" },
		{ "<leader>gn", "<cmd>CodeCompanionChat<cr>",        mode = "n",          desc = "CodeCompanionChat Toggle" },
		{ "<leader>gi", "<cmd>CodeCompanion<cr>",            mode = { "n", "v" }, desc = "CodeCompanion" },
		{ "<leader>ga", "<cmd>CodeCompanionChat Add<cr>",    mode = "v",          desc = "CodeCompanionChat Add" },
	}
}
