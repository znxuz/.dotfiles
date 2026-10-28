local drivers = {
	'sql-staging',
	'sql-prod'
}

local function execute_query(q)
	vim.ui.select(drivers, {
		prompt = 'sql drivers:'
	}, function (choice)
		if choice ~= nil then
			run_shell_cmd(choice .. ' "' .. q:gsub('"', '\\"') .. '"')
		end
	end)
end

vim.keymap.set("n", "<leader><leader>", function()
	local line = vim.api.nvim_get_current_line()
	local q = line:sub(1, 1) == '"' and line:sub(-1) == '"' and line:sub(2, -2) or line
	execute_query(q)
end, { buffer = true })

vim.keymap.set("v", "<leader><leader>", function()
	local s, e = vim.fn.getpos("'<"), vim.fn.getpos("'>")
	local lines = vim.api.nvim_buf_get_lines(0, s[2] - 1, e[2], false)
	if #lines == 0 then return end
	if #lines == 1 then
		lines[1] = lines[1]:sub(s[3], e[3])
	else
		lines[1] = lines[1]:sub(s[3]); lines[#lines] = lines[#lines]:sub(1, e[3])
	end
	local text = table.concat(lines, "\n")
	local q = text:sub(1, 1) == '"' and text:sub(-1) == '"' and text:sub(2, -2) or text
	execute_query(q)
end, { buffer = true })
