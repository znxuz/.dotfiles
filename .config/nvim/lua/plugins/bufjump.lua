return {
	"kwkarlwang/bufjump.nvim",
	config = function()
		require("bufjump").setup({
			forward_key = false,
			backward_key = false,
			on_success = nil
		})
	end,
	keys = {
		{ "g<c-o>", "<cmd>lua require('bufjump').backward()<cr>", mode = "n" },
		{ "g<c-i>", "<cmd>lua require('bufjump').forward()<cr>",  mode = "n" },
	}
}
