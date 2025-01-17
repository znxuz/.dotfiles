return {
	"olimorris/codecompanion.nvim",
	enabled = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		display = {
			chat = {
				window = {
					layout = "float", -- float|vertical|horizontal|buffer
					border = "single",
					height = 0.8,
					width = 0.8,
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
			chat = {
				adapter = "openai",
				keymaps = {
					options = { modes = { n = "g?" } },
					send = { modes = { i = "<C-g><C-g>" }, },
				},
			},
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
							},
						},
						temperature = { default = 0.3, },
						top_p = { default = 0.2, },
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
	}
}
