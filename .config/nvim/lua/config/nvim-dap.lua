local dap, dapui = require('dap'), require('dapui')

dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end

-- C/C++
dap.adapters.cppdbg = {
  type = 'executable',
  command = vim.env.HOME .. '/.local/share/vscode-cpptools/extension/debugAdapters/bin/OpenDebugAD7',
}
dap.configurations.c = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}
dap.configurations.cpp = dap.configurations.c

require('dapui').setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
	id = "scopes",
	size = 0.25, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.25 },
      { id = "stacks", size = 0.25 },
      { id = "watches", size = 00.25 },
    },
    size = 40,
    position = "left", -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    elements = { "repl" },
    size = 10,
    position = "bottom", -- Can be "left", "right", "top", "bottom"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
})

local map = require('config.mapper').map
map("n", "<leader>dd", function () require'dap'.continue() end)
map("n", "<leader>dj", function () require'dap'.step_over() end)
map("n", "<leader>dl", function () require'dap'.step_into() end)
map("n", "<leader>dk", function () require'dap'.step_out() end)
map("n", "<leader>de", function () require'dap'.disconnect() require'dap'.close() end)
map("n", "<leader>d^", function () require'dap'.run_last() end)
map("n", "<leader>drc", function () require'dap'.run_to_cursor() end)
map("n", "<leader>dbp", function () require'dap'.toggle_breakpoint() end)
