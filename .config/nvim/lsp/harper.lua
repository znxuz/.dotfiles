return {
	cmd = { "harper-ls", "--stdio" },
	settings = {
		["harper-ls"] = {
			markdown = { IgnoreLinkTitle = true },
			isolateEnglish = true,
		}
	},
	root_markers = { ".git" },
	filetypes = { 'markdown' },
}
