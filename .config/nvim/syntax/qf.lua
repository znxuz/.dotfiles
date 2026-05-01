local win_id = vim.api.nvim_get_current_win()
vim.api.nvim_win_set_hl_ns(win_id, vim.api.nvim_create_namespace("qf_highlight_" .. win_id))

vim.fn.matchadd("NonText", "\\[+\\]", 10, -1, { window = win_id })
