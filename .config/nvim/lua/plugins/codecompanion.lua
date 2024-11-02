return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		strategies = {
			chat = { adapter = "openai" },
			inline = { adapter = "openai" },
		},
		adapters = {
			openai = function()
				return require("codecompanion.adapters").extend("openai", {
					env = { api_key = "cmd: pass openai" },
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
