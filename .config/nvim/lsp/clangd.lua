return {
	cmd = { 'clangd',
		'--background-index',
		'--log=error',
		'--query-driver=/usr/bin/arm-none-eabi-gcc,/usr/bin/arm-none-eabi-g++'
	},
	root_markers = {
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
