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
							default = "o1-mini",
							choices = {
								"gpt-4o",
								"gpt-4o-mini",
							},
						},
						temperature = { default = 1, },
						top_p = { default = 1, },
					},
				})
			end,
		},
	},
	keys = {
		{ "<leader>G",  "<cmd>CodeCompanionActions<cr>",     mode = { "n", "v" }, desc = "CodeCompanion Actions" },
		{ "<leader>gg", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "CodeCompanionChat Toggle" },
		{ "<leader>gi", "<cmd>CodeCompanion<cr>",            mode = { "n", "v" }, desc = "CodeCompanion" },
		{ "<leader>ga", "<cmd>CodeCompanionChat Add<cr>",    mode = "v",          desc = "CodeCompanionChat Add" },
	},
	enabled = false
}
