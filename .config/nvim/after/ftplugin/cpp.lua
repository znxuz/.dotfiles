local function cpp_check()
	local save_makeprg = vim.opt_local.makeprg
	local status, err = pcall(function()
		vim.opt_local.makeprg = 'cppcheck'
		vim.cmd.make('--suppress=missingIncludeSystem --enable=all src/')
	end)
	vim.opt_local.makeprg = save_makeprg
	if not status then
		vim.api.nvim_echo({
			{ "Error during cpp_check: " .. tostring(err), "ErrorMsg" },
		}, true, {})
	end
end
vim.api.nvim_create_user_command('CppCheck', function() cpp_check() end, { nargs = 0 })

local function configure_makeprg()
	local function configure()
		local search_dir = vim.fn.expand('%:p:h')
		local stop_dir = vim.env.HOME
		while true do
			if vim.fn.filereadable(search_dir .. '/Makefile') == 1 then
				break
			elseif vim.fn.filereadable(search_dir .. '/CMakeLists.txt') == 1 then
				vim.opt_local.makeprg = 'cmake'
				break
			elseif search_dir == stop_dir or search_dir == '/' then
				break
			end
			search_dir = vim.fn.fnamemodify(search_dir, ':h')
		end
	end
	local function map()
		local build_dir = './build'
		local function clean() vim.fn.system('rm -rf ' .. build_dir) end
		local function generate(rebuild)
			if rebuild then clean() end
			vim.cmd.make('-B ' .. build_dir)
		end
		local function build(clean_first)
			arg = '--build ' .. build_dir
			if clean_first then arg = arg .. ' --clean-first' end
			vim.cmd.make(arg)
		end
		local function run()
			build()
			local bin = vim.system({ 'find',
					build_dir,
					'-maxdepth',
					'1',
					'-type',
					'f',
					'-executable' }, { text = true }):wait()
			if bin.code ~= 0 then
				vim.api.nvim_echo({ { "Error: " .. tostring(bin.stderr), "ErrorMsg" }, }, true, {})
				return
			end
			print(vim.fn.system(bin.stdout))
		end
		vim.keymap.set('n', '<leader>mg', generate, { buffer = true })
		vim.keymap.set('n', '<leader>mG', function() generate(true) end, { buffer = true })
		vim.keymap.set('n', '<leader>mm', build, { buffer = true })
		vim.keymap.set('n', '<leader>mM', function() build(true) end, { buffer = true })
		vim.keymap.set('n', '<leader>mc', clean, { buffer = true })
		vim.keymap.set('n', '<leader>mr', run, { buffer = true })
		-- TODO ctest mappings
	end

	configure()
	map()
end
configure_makeprg()

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach", { clear = false }),
	callback = function ()
		local function switch_source_header_splitcmd(bufnr, splitcmd)
			local params = { uri = vim.uri_from_bufnr(bufnr) }
			vim.lsp.buf_request(bufnr, 'textDocument/switchSourceHeader', params,
				function(err, result, _)
					if err then error(tostring(err)) end
					if not result then
						vim.api.nvim_echo({ { "Corresponding file can’t be determined", "ErrorMsg" }, }, true, {})
						return
					end
					vim.api.nvim_command(splitcmd .. ' ' .. vim.uri_to_fname(result))
				end)
		end

		vim.keymap.set('n', '<leader><c-^>',
			function()
				switch_source_header_splitcmd(0, 'edit')
			end, { buffer = true })
	end
})
