return {
	"kwkarlwang/bufjump.nvim",
	config = function()
		require("bufjump").setup({
			forward_key = nil,
			backward_key = nil,
			on_success = nil
		})
	end,
	keys = {
		{ "g<C-o>", "<cmd>lua require('bufjump').backward()<cr>", mode = "n" },
		{ "g<C-i>", "<cmd>lua require('bufjump').forward()<cr>",  mode = "n" },
	}
}
