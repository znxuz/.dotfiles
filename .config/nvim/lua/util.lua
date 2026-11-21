local M = {}
local SEARCH_CMD = 'ag -US --nocolor -p $HOME/.config/fd/ignore'

-- TODO: replace search engine with rg
M.search = {
	constants = {
		FIND_CMD = SEARCH_CMD .. ' --filename',
		FIND_EFM = "%f",
		GREP_CMD = SEARCH_CMD .. ' --vimgrep --hidden --numbers', --numbers needed; bug in ag?
		GREP_EFM = "%f:%l:%c:%m"
	},
	enable_fuzzy_if = function(s)
		local pattern = s:match("^(%S+)") or s
		local rest = s:sub(#pattern + 1)
		if pattern:sub(1, 1) == "*" then
			pattern = '"' .. pattern:gsub("^%*", ""):gsub(".", ".*%0") .. ".*" .. '"'
		elseif pattern:find("%.%*") then
			pattern = '"' .. pattern .. '"'
		end
		return pattern .. rest
	end
}
M.search.find_or_filter = function(arg, _, from)
	local cmd = M.search.constants.FIND_CMD .. ' ' .. M.search.enable_fuzzy_if(arg)
	if not from then
		 -- -g: prints filenames without extra stdin
		return vim.fn.systemlist(cmd .. ' -g')
	else
		-- w/o -g: search given a stdin i.e. `from`
		return vim.fn.systemlist(cmd, from)
	end
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
	vim.fn.setloclist(0, {}, ' ', {
		lines = filenames,
		efm = M.search.constants.FIND_EFM,
		title = title,
		quickfixtextfunc = function(_)
			local files = vim.deepcopy(filenames) -- needed
			if not opts then return files end
			for i, f in ipairs(files) do
				if opts.show_modified and vim.fn.getbufvar(f, '&mod') == 1 then
					files[i] = files[i] .. ' [+]'
				end
				if opts.show_lastused then
					files[i] = files[i] .. ' | '
							.. os.date("%Mm %Ss", vim.uv.gettimeofday() - vim.fn.getbufinfo(f)[1].lastused) .. ' ago'
				end
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
