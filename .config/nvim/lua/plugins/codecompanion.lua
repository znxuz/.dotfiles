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
					system_prompt = false, -- conflict with gs
					options = { modes = { n = "gh" } },
					clear = { modes = { n = "gw" } },
					next_chat = { modes = { n = "<C-n>" } },
					previous_chat = { modes = { n = "<C-p>" } },
					watch = { modes = { n = "g_" } },
					regenerate = { modes = { n = "gre" } },
				},
				roles = {
					llm = function(adapter) return adapter.name end,
					user = "Me",
				}
			}
		},
		adapters = {
			http = {
				or_gemini = function()
					return require("codecompanion.adapters").extend("openai", {
						name = "gemini",
						env = { api_key = "cmd: pass openrouter" },
						url = "https://openrouter.ai/api/v1/chat/completions",
						schema = {
							model = {
								default = "google/gemini-2.5-flash",
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
								default = "deepseek/deepseek-v3.2-exp"
							},
						}
					})
				end
			}
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
