return {
	cmd = { "harper-ls", "--stdio" },
	settings = {
		["harper-ls"] = {
			linters = {
				SentenceCapitalization = false,
				SpellCheck = false
			},
			markdown = { IgnoreLinkTitle = true },
			isolateEnglish = true,
		}
	},
	root_markers = { ".git" },
	filetypes = { 'markdown' },
}
