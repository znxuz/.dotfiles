-- TODO show list on command and refresh on key?

vim.keymap.set('n', '<leader>L', '<Cmd>Lazy<Cr>')

local AG = 'ag -US --nocolor -p $HOME/.config/fd/ignore'
local FIND_CMD = AG .. ' --filename'
local GREPPRG = AG .. '--vimgrep --hidden'
local function enable_fuzzy_if(s)
	local pattern = s:match("^(%S+)") or s
	local rest = s:sub(#pattern + 1)
	if pattern:sub(1, 1) == "*" then
		pattern = '"' .. pattern:gsub("^%*", ""):gsub(".", ".*%0") .. ".*" .. '"'
	elseif pattern:find("%.%*") then
		pattern = '"' .. pattern .. '"'
	end
	return pattern .. rest
end
local function shorten_path(path)
	return vim.fn.fnamemodify(path, ":~:.")
end

-- keymap for populating qf list without leaving the cmdline
vim.keymap.set('c', '<c-l>', function()
	local first_word = vim.fn.getcmdline():match('^(%S+)')
	if first_word == 'Find' or first_word == 'Buf' or first_word == 'Gr' then
		return '<cr>:<up>'
	else
		return '<c-l>'
	end
end, { expr = true })

-- find
function Find(arg, _)
	return vim.fn.systemlist(FIND_CMD .. ' -g ' .. enable_fuzzy_if(arg))
end

vim.api.nvim_create_user_command('Find', function(opts)
	local result = Find(opts.args)
	for i, entry in ipairs(result) do
		result[i] = shorten_path(entry)
	end

	vim.fn.setloclist(0, {}, ' ', {
		lines = result,
		efm = '%f',
		title = opts.name,
		quickfixtextfunc = function(_) return result end -- show just filenames w/o seperators
	})
	vim.cmd.lw()
end, { nargs = '+', complete = 'file' })
vim.opt.findfunc = "v:lua.Find"
vim.keymap.set("n", "gs", ":Find ")
vim.keymap.set("v", "gs", [["ty:Find t<cr>]])

-- buffer
vim.api.nvim_create_user_command('Buf', function(opts)
	local bufs = vim.iter(vim.api.nvim_list_bufs())
			:filter(function(b)
				return vim.fn.buflisted(b) == 1
						-- and vim.api.nvim_buf_is_loaded(b)
						-- and b ~= vim.api.nvim_get_current_buf()
			end)
			:totable()
	table.sort(bufs, function(a, b)
		return vim.fn.getbufinfo(a)[1].lastused > vim.fn.getbufinfo(b)[1].lastused
	end)
	local bufnames = vim.iter(bufs)
			:map(vim.api.nvim_buf_get_name)
			:filter(function(name) return name ~= '' end)
			:map(shorten_path)
			:totable()

	local search_term = tonumber(opts.args)
			and '^' .. shorten_path(vim.api.nvim_buf_get_name(tonumber(opts.args) or 0)) .. '$'
			or enable_fuzzy_if(opts.args)
	local result = string.len(opts.args) ~= 0
			and vim.fn.systemlist('echo "' .. table.concat(bufnames, "\n") .. '" | ' .. FIND_CMD .. ' ' .. search_term)
			or bufnames

	vim.fn.setloclist(0, {}, ' ', {
		lines = result,
		efm = '%f',
		title = opts.name,
		quickfixtextfunc = function(_) return result end
	})
	vim.cmd.lw()
end, { nargs = '*', complete = 'file' })
vim.keymap.set("n", "gb", '<cmd>Buf<cr>:Buf ')

-- grep
vim.o.grepprg = GREPPRG
vim.api.nvim_create_user_command('Gr', function(opts)
	vim.cmd('sil gr! ' .. enable_fuzzy_if(opts.args))
	vim.cmd.cw()
end, { nargs = '+', complete = 'file' })
vim.keymap.set("n", "gp", ":Gr ")
vim.keymap.set("v", "gp", [["ty:Gr -Q 't'<cr>]])

-- shell cmd
vim.keymap.set("n", "<leader><leader>", function()
	vim.ui.input({ prompt = "> ", completion = "shellcmdline" }, function(c)
		if c and c ~= "" then
			vim.cmd("nos enew")
			vim.bo.buftype = "nofile"
			vim.bo.bufhidden = "wipe"
			vim.bo.filetype = "compiler" -- depends on syntax/compiler.vim
			vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.systemlist(c))
		end
	end)
end)

-- true/false toggle
vim.keymap.set('n', 'g~', function()
	local word = vim.fn.expand('<cword>')
	if word == 'true' then
		vim.cmd('norm ciwfalse')
	elseif word == 'false' then
		vim.cmd('norm ciwtrue')
	end
end, { silent = true })

-- toggle term
local term_name = "term://toggleterm"
local function toggleterm()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_get_name(buf):find(term_name) then
			vim.cmd("sb " .. buf)
			return
		end
	end
	vim.cmd.split()
	vim.cmd.term()
	vim.api.nvim_buf_set_name(0, term_name)
end
vim.keymap.set('n', '<A-enter>', function()
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win)):find(term_name) then
			vim.api.nvim_win_close(win, false)
			return
		end
	end
	toggleterm()
end)
vim.keymap.set('t', '<A-enter>', function()
	if vim.api.nvim_buf_get_name(0):find(term_name) then
		vim.cmd.close()
	end
end)

-- notification upon cmd finish `-h shell-prompt`
vim.api.nvim_create_autocmd('TermRequest', {
	group = vim.api.nvim_create_augroup("term_prompt_notification", {}),
	desc = 'Handles OSC 7 dir change requests',
	callback = function(ev)
		local row = ev.data.cursor[1]
		if row == 1 then return end
		print("command finished")
	end
})
