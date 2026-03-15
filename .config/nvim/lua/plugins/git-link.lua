return {
	"juacker/git-link.nvim",
	keys = {
		{
			"<leader>gy",
			function() require("git-link.main").copy_line_url() end,
			desc = "Copy code link to clipboard",
			mode = { "n", "x" }
		}
	},
}
