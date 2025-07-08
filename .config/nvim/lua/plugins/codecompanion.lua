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
					layout = "buffer",
					opts = {
						cursorline = true,
						spell = true,
					}
				},
				intro_message = "",
			},
		},
		strategies = {
			inline = { adapter = "or_deepseek" },
			chat = {
				adapter = "or_deepseek",
				keymaps = {
					options = { modes = { n = "gh" } },
					clear = { modes = { n = "gw" } },
					next_chat = { modes = { n = "<C-n>" } },
					previous_chat = { modes = { n = "<C-p>", }, },
					watch = { modes = { n = "g_" } },
				},
				roles = {
					llm = function(adapter) return adapter.name end,
					user = "Me",
				}
			}
		},
		adapters = {
			or_openai = function()
				return require("codecompanion.adapters").extend("openai", {
					name = "openai",
					env = { api_key = "cmd: pass openrouter" },
					url = "https://openrouter.ai/api/v1/chat/completions",
					schema = {
						model = {
							default = "openai/gpt-4.1",
							choices = {
								"openai/gpt-4.1",
								"openai/gpt-4o",
							},
						},
					}
				})
			end,
			or_deepseek = function()
				return require("codecompanion.adapters").extend("openai", {
					name = "deepseek",
					env = { api_key = "cmd: pass openrouter" },
					url = "https://openrouter.ai/api/v1/chat/completions",
					schema = {
						model = {
							default = "deepseek/deepseek-chat-v3-0324"
						},
					}
				})
			end
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
