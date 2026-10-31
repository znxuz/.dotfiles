-- highlight [+] string for qf buffers
local win_id = vim.api.nvim_get_current_win()
vim.api.nvim_win_set_hl_ns(win_id, vim.api.nvim_create_namespace("qf_highlight_" .. win_id))
vim.fn.matchadd("NonText", "\\[+\\]", 10, -1, { window = win_id })

-- Per-entry, regex-based (:syntax) language highlighting for quickfix/loclist.
-- Each snippet is run through the syntax engine in an isolated scratch buffer
-- (contained regions with `extend`, e.g. C's cComment, would otherwise leak
-- across qf lines) and the resulting groups are copied as extmarks.

-- totally vibed by the llm

local NS = vim.api.nvim_create_namespace('qf_lang_syntax')

local sbufs = {}      -- filetype -> scratch buffer used to resolve syntax
local runs_cache = {} -- "ft\0message" -> { {start0, end0, hl_group}, ... }
local built = {}      -- bufnr -> changedtick at last build

local function item_filetype(item)
	if item.bufnr and item.bufnr > 0 and vim.api.nvim_buf_is_valid(item.bufnr) then
		if vim.bo[item.bufnr].filetype ~= '' then return vim.bo[item.bufnr].filetype end
		local name = vim.api.nvim_buf_get_name(item.bufnr)
		if name ~= '' then return vim.filetype.match({ filename = name }) end
	end
	if item.filename and item.filename ~= '' then
		return vim.filetype.match({ filename = item.filename })
	end
end

local function scratch(ft)
	local buf = sbufs[ft]
	if buf and vim.api.nvim_buf_is_valid(buf) then return buf end
	buf = vim.api.nvim_create_buf(false, true)
	vim.bo[buf].bufhidden = 'hide'
	vim.api.nvim_buf_call(buf, function()
		vim.b.current_syntax = nil -- defeat the `b:current_syntax` guard
		vim.bo.syntax = ft
	end)
	sbufs[ft] = buf
	return buf
end

-- Highlight runs (0-based, end-exclusive) for `msg` under filetype `ft`.
local function runs(ft, msg)
	local key = ft .. '\0' .. msg
	if runs_cache[key] then return runs_cache[key] end

	local buf, out = scratch(ft), {}
	vim.api.nvim_buf_call(buf, function()
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, { msg })
		local n, prev, start = #msg, '', 1
		for col = 1, n + 1 do
			local name = ''
			if col <= n then
				local id = vim.fn.synID(1, col, 1)
				if id ~= 0 then name = vim.fn.synIDattr(vim.fn.synIDtrans(id), 'name') end
			end
			if name ~= prev then
				if prev ~= '' and prev ~= 'Normal' then out[#out + 1] = { start - 1, col - 1, prev } end
				prev, start = name, col
			end
		end
	end)

	runs_cache[key] = out
	return out
end

-- Byte offset (1-based) of the message part of a displayed qf line: after the
-- second `|` separator. nil when the line has no message (e.g. filename lists).
local function message_start(line)
	local p1 = line:find('|', 1, true)
	local p2 = p1 and line:find('|', p1 + 1, true)
	if not p2 then return end
	local s = p2 + 1
	if line:sub(s, s) == ' ' then s = s + 1 end
	return s
end

local function build(buf)
	if not (vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == 'quickfix') then return end
	local win = vim.fn.bufwinid(buf)
	if win == -1 then return end -- not displayed yet; BufWinEnter will build it
	if built[buf] == vim.b[buf].changedtick then return end
	built[buf] = vim.b[buf].changedtick

	local items = (vim.fn.getwininfo(win)[1].loclist == 1 and vim.fn.getloclist(win, { items = 1 })
		or vim.fn.getqflist({ items = 1 })).items
	local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

	vim.api.nvim_buf_clear_namespace(buf, NS, 0, -1)
	for i, line in ipairs(lines) do
		local item = items[i]
		local ft = item and item_filetype(item)
		local s = ft and message_start(line)
		if s then
			local msg = line:sub(s)
			for _, r in ipairs(runs(ft, msg)) do
				vim.api.nvim_buf_set_extmark(buf, NS, i - 1, s - 1 + r[1], {
					end_col = s - 1 + r[2],
					hl_group = r[3],
				})
			end
		end
	end
end

vim.api.nvim_create_autocmd({ 'BufWinEnter', 'QuickFixCmdPost' }, {
	group = vim.api.nvim_create_augroup('qf_lang_syntax', { clear = true }),
	callback = function(ev)
		if ev.event == 'QuickFixCmdPost' then
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do build(buf) end
		else
			build(ev.buf)
		end
	end,
})
