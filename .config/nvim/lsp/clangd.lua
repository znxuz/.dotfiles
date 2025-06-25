return {
	cmd = { 'clangd',
		'--background-index',
		'--log=error',
		-- '--header-insertion=never',
		'--query-driver=/usr/bin/arm-none-eabi-gcc,/usr/bin/arm-none-eabi-g++'
	},
	root_markers = {
		'.cache',
		'.clangd',
		'.clang-format',
		'.clang-tidy',
		'compile_commands.json',
		'compile_flags.txt',
	},
	capabilities = {
		textDocument = { completion = { editsNearCursor = true } },
		offsetEncoding = { 'utf-8', 'utf-16' },
	},
	filetypes = { 'c', 'cpp' },
}
