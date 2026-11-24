local M = {}

local ARGS = {
	"rg",
	"--smart-case",
	"--hidden",
	"--ignore-file=" .. vim.env.HOME .. "/.config/fd/ignore",
	-- "--no-ignore-vcs",
	-- "--sort=path"
}
local SEARCH_CMD = table.concat(ARGS, " ")

M.search = {
	constants = {
		FIND_CMD = SEARCH_CMD,
		FIND_EFM = "%f",
		GREP_CMD = SEARCH_CMD .. ' --vimgrep',
		GREP_EFM = "%f:%l:%c:%m"
	},
	try_enable_fuzzy = function(s)
		local pat = s:match("^(%S+)") or s
		local rest = s:sub(#pat + 1)
		if pat:sub(1, 1) == "*" then
			-- dont need to double quote the pattern if its supplied as execvp arg instead of being passed into shell
			pat = pat:gsub("^%*", ""):gsub(".", ".*%0") .. ".*"
		end
		return pat .. rest
	end,
	get_result = function(cmd, stdin)
		local out = vim.system(cmd, { text = true, stdin = stdin }):wait().stdout
		return out and vim.split(out, "\n", { trimempty = true }) or {}
	end
}

M.search.find_or_filter = function(args, _, from)
	local pat, dir = args:match("(%S+)%s*(%S*)")
	local entries = from or
			M.search.get_result(vim.list_extend(vim.deepcopy(ARGS), { "--files", (dir and dir ~= "") and dir or nil }))
	local cmd = vim.list_extend(vim.deepcopy(ARGS), { M.search.try_enable_fuzzy(pat) })
	return M.search.get_result(cmd, entries)
end

M.shorten_path = function(path)
	if path ~= "" then
		path = vim.fn.fnamemodify(path, ":~:.")
	end
	return path
end

M.open_or_focus_qflist = function(is_loc)
	if is_loc then
		pcall(vim.cmd.lcl)
		pcall(vim.cmd.lw)
	else
		pcall(vim.cmd.ccl)
		pcall(vim.cmd.cw)
	end
end

M.populate_loclist = function(filenames, title, opts)
	opts = opts or {}
	local winid = opts.winid or 0
	local action = opts.action or ' '

	if action == 'r' then
		vim.fn.setloclist(winid, {}, 'r', { items = {} })
	end

	vim.fn.setloclist(winid, {}, action, {
		lines = filenames,
		efm = M.search.constants.FIND_EFM,
		title = title,
		quickfixtextfunc = function(info)
			local files = {}
			local items = vim.fn.getloclist(info.winid, { id = info.id, items = 1 }).items
			if not items then return end
			for i = info.start_idx, info.end_idx do
				local item = items[i]
				local f = item and item.bufnr > 0 and M.shorten_path(vim.fn.bufname(item.bufnr)) or ''
				if opts.show_modified and vim.fn.getbufvar(f, '&mod') == 1 then
					f = f .. ' [+]'
				end
				if opts.show_lastused and f ~= '' then
					local bufinfo = vim.fn.getbufinfo(f)[1]
					if bufinfo then
						f = f .. ' | ' .. os.date("%Mm %Ss", vim.uv.gettimeofday() - bufinfo.lastused) .. ' ago'
					end
				end
				table.insert(files, f)
			end
			return files
		end
	})
end

M.run_shell_cmd = function(cmd)
	if not cmd or cmd == "" then return end

	-- local w = vim.api.nvim_get_current_win()
	local scratch_buf = vim.api.nvim_create_buf(false, true)
	vim.fn.jobstart({ vim.o.sh, "-c", cmd }, {
		on_stdout = function(_, data, _)
			vim.api.nvim_buf_set_lines(scratch_buf, -2, -1, false, data)
		end,
		on_stderr = function(_, data, _)
			vim.api.nvim_buf_set_lines(scratch_buf, -2, -1, false, data)
		end,
	})
	vim.cmd.sb(scratch_buf)
	-- vim.api.nvim_set_current_win(w)
end

M.is_loc = function(winid)
	return vim.fn.getwininfo(winid or vim.fn.win_getid())[1].loclist == 1
end

return M
