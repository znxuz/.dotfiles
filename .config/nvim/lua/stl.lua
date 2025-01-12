local function diagnostic_count()
	local cur = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = cur })
	if #clients == 0 then
		return ""
	end

	local warn = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
	local err = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
	if warn ~= 0 or err ~= 0 then
		-- return string.format("⚠️%d ❌%d", warn, err)
		return string.format(" %d  %d", warn, err)
	end
	return ""
end

local padding = "  | "
local modules = {
	diagnostic_count
}

local M = {}

M.inject_lsp = function()
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
