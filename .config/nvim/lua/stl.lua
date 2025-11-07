local function diagnostic_count()
	local cur = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = cur })
	if #clients == 0 then
		return ""
	end

	local err = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
	local warn = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
	if err ~= 0 or warn ~= 0 then
		return string.format(" %d  %d", err, warn)
	end
	return ""
end

local padding = "  | "
local modules = {
	diagnostic_count
}

local M = {}

M.inject = function()
	local stl = ""
	for _, func in ipairs(modules) do
		local result = func()
		if result ~= "" then
			stl = stl .. padding .. result
		end
	end
	return stl
end

return M
