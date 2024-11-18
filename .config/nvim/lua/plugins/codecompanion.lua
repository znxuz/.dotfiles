return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		display = {
			chat = {
				window = {
					layout = "horizontal", -- float|vertical|horizontal|buffer
					border = "single",
					-- height = 0.5,
					-- width = 0.5,
					opts = {
						cursorline = true,
						spell = true,
					},
				},
				intro_message = "",
				show_settings = true
			},
		},
		strategies = {
			chat = { adapter = "openai" },
			inline = { adapter = "openai" },
		},
		adapters = {
			openai = function()
				return require("codecompanion.adapters").extend("openai", {
					env = { api_key = "cmd: pass openai" },
					schema = {
						model = {
							default = "gpt-4o",
							choices = {
								"gpt-4o",
								"gpt-4o-mini",
								"gpt-4-turbo-preview",
								"gpt-4",
								"gpt-3.5-turbo",
							},
						},
						temperature = { default = 0.6, },
						top_p = { default = 0.5, },
					},
				})
			end,
		},
	},
	keys = {
		{ "<leader>G",  "<cmd>CodeCompanionActions<cr>",     mode = { "n", "v" } },
		{ "<leader>gg", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" } },
		{ "<leader>gi", "<cmd>CodeCompanion<cr>",            mode = { "n", "v" } },
		{ "<leader>ga", "<cmd>CodeCompanionChat Add<cr>",    mode = "v" },
	},
}
