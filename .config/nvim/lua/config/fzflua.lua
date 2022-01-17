local actions = require('fzf-lua.actions')
require('fzf-lua').setup {
	winopts = {
		-- border argument passthrough to nvim_open_win(), also used
		-- to manually draw the border characters around the preview
		-- window, can be set to 'false' to remove all borders or to
		-- 'none', 'single', 'double' or 'rounded' (default)
		border           = 'single',
		preview = {
			hidden         = 'nohidden',      -- hidden|nohidden
			vertical       = 'down:45%',      -- up|down:size
			horizontal     = 'right:60%',     -- right|left:size
			layout         = 'flex',          -- horizontal|vertical|flex
			flip_columns   = 120,             -- #cols to switch to horizontal on flex
			scrollbar      = 'float',         -- `false` or string:'float|border'
																				-- float:  in-window floating border
																				-- border: in-border chars (see below)
			scrolloff      = '-2',            -- float scrollbar offset from right
																				-- applies only when scrollbar = 'float'
			scrollchars    = {'█', '' },      -- scrollbar chars ({ <full>, <empty> }
																				-- applies only when scrollbar = 'border'
			delay          = 0,
			winopts = {
				number            = false,
				relativenumber    = false,
				cursorline        = true,
				cursorlineopt     = 'both',
				cursorcolumn      = false,
				signcolumn        = 'no',
				list              = false,
				foldenable        = false,
				foldmethod        = 'manual',
			}
		}
	},
  keymap = {
    -- These override the default tables completely
    -- no need to set to `false` to disable a bind
    -- delete or modify is sufficient
    builtin = {
      -- neovim `:tmap` mappings for the fzf win
      ["<F2>"]        = "toggle-fullscreen",
      -- Only valid with the 'builtin' previewer
      ["<F3>"]        = "toggle-preview-wrap",
      ["<F4>"]        = "toggle-preview",
      -- Rotate preview clockwise/counter-clockwise
      ["<F5>"]        = "toggle-preview-ccw",
      ["<F6>"]        = "toggle-preview-cw",
      ["<S-down>"]    = "preview-page-down",
      ["<S-up>"]      = "preview-page-up",
      ["<S-left>"]    = "preview-page-reset",
    },
    fzf = {
      -- fzf '--bind=' options
      ["ctrl-z"]      = "abort",
      ["ctrl-u"]      = "unix-line-discard",
      ["ctrl-f"]      = "half-page-down",
      ["ctrl-b"]      = "half-page-up",
      ["ctrl-a"]      = "beginning-of-line",
      ["ctrl-e"]      = "end-of-line",
      ["alt-a"]       = "toggle-all",
    },
  },
  fzf_opts = {
    -- options are sent as `<left>=<right>`
    -- set to `false` to remove a flag
    -- set to '' for a non-value flag
    -- for raw args use `fzf_args` instead
    ['--ansi']        = '',
    ['--info']        = 'inline',
    ['--height']      = '100%',
    ['--layout']      = 'reverse',
  },
  -- provider setup
  files = {
    multiprocess      = true,           -- run command in a separate process
    git_icons         = false,           -- show git icons?
    file_icons        = false,           -- show file icons?
    color_icons       = false,           -- colorize file|git icons
    -- executed command priority is 'cmd' (if exists)
    -- otherwise auto-detect prioritizes `fd`:`rg`:`find`
    -- default options are controlled by 'fd|rg|find|_opts'
    -- NOTE: 'find -printf' requires GNU find
    -- cmd            = "find . -type f -printf '%P\n'",
    find_opts         = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
    fd_opts           = "--color=never -tf -H -L -E.git -E.cache",
    rg_opts           = "--color=never --files --hidden --follow -g '!.git'",
    actions = {
      -- set bind to 'false' to disable an action
      -- default action opens a single selection
      -- or sends multiple selection to quickfix
      -- replace the default action with the below
      -- to open all files whether single or multiple
      -- ["default"]     = actions.file_edit,
      ["default"]     = actions.file_edit_or_qf,
      ["ctrl-s"]      = actions.file_split,
      ["ctrl-v"]      = actions.file_vsplit,
      ["ctrl-t"]      = actions.file_tabedit,
      ["alt-q"]       = actions.file_sel_to_qf
    }
  },
  git = {
    files = {
      cmd             = 'git ls-files --exclude-standard',
      multiprocess    = false,          -- run command in a separate process
      git_icons       = false,           -- show git icons?
      file_icons      = false,           -- show file icons?
      color_icons     = false,           -- colorize file|git icons
      -- force display the cwd header line regardles of your current working directory
      -- can also be used to hide the header when not wanted
      -- show_cwd_header = true
    },
    status = {
      cmd             = "git status -s",
      previewer       = "git_diff",
      file_icons      = false,
      git_icons       = false,
      color_icons     = false,
      actions = {
        ["default"]   = actions.file_edit_or_qf,
        ["ctrl-s"]    = actions.file_split,
        ["ctrl-v"]    = actions.file_vsplit,
        ["ctrl-t"]    = actions.file_tabedit,
        ["alt-q"]     = actions.file_sel_to_qf,
        ["right"]     = { actions.git_unstage, actions.resume },
        ["left"]      = { actions.git_stage, actions.resume },
      },
    },
    commits = {
      cmd             = "git log --pretty=oneline --abbrev-commit --color",
      preview         = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
      actions = {
        ["default"] = actions.git_checkout,
      },
    },
    bcommits = {
      cmd             = "git log --pretty=oneline --abbrev-commit --color",
      preview         = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
      actions = {
        ["default"] = actions.git_buf_edit,
        ["ctrl-s"]  = actions.git_buf_split,
        ["ctrl-v"]  = actions.git_buf_vsplit,
        ["ctrl-t"]  = actions.git_buf_tabedit,
      },
    },
    branches = {
      cmd             = "git branch --all --color",
      preview         = "git log --graph --pretty=oneline --abbrev-commit --color {1}",
      actions = {
        ["default"] = actions.git_switch,
      },
    },
    icons = {
      ["M"]           = { icon = "M", color = "yellow" },
      ["D"]           = { icon = "D", color = "red" },
      ["A"]           = { icon = "A", color = "green" },
      ["?"]           = { icon = "?", color = "magenta" },
      -- override git icons?
      -- ["M"]        = { icon = "★", color = "red" },
      -- ["D"]        = { icon = "✗", color = "red" },
      -- ["A"]        = { icon = "+", color = "green" },
    },
  },
  grep = {
    multiprocess      = true,           -- run command in a separate process
    git_icons         = false,           -- show git icons?
    file_icons        = false,           -- show file icons?
    color_icons       = false,           -- colorize file|git icons
    -- executed command priority is 'cmd' (if exists)
    -- otherwise auto-detect prioritizes `rg` over `grep`
    -- default options are controlled by 'rg|grep_opts'
    -- cmd            = "rg --vimgrep",
    rg_opts           = "--column --line-number --no-heading --color=always --smart-case --max-columns=512",
    grep_opts         = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp",
    -- 'live_grep_glob' options:
    glob_flag         = "--iglob",  -- for case sensitive globs use '--glob'
    glob_separator    = "%s%-%-"    -- query separator pattern (lua): ' --'
  },
  args = {
    files_only        = true,
    -- added on top of regular file actions
    actions           = { ["ctrl-x"] = actions.arg_del }
  },
  oldfiles = {
    cwd_only          = false,
    file_icons        = false,
    color_icons       = false,
  },
  buffers = {
    file_icons        = false,
    color_icons       = false,
    sort_lastused     = true,
    actions = {
      ["default"]     = actions.buf_edit,
      ["ctrl-s"]      = actions.buf_split,
      ["ctrl-v"]      = actions.buf_vsplit,
      ["ctrl-t"]      = actions.buf_tabedit,
      -- by supplying a table of functions we're telling
      -- fzf-lua to not close the fzf window, this way we
      -- can resume the buffers picker on the same window
      -- eliminating an otherwise unaesthetic win "flash"
      ["ctrl-x"]      = { actions.buf_del, actions.resume },
    }
  },
  lines = {
    previewer         = "builtin",    -- set to 'false' to disable
    show_unlisted     = false,        -- exclude 'help' buffers
    no_term_buffers   = true,         -- exclude 'term' buffers
    fzf_opts = {
      -- do not include bufnr in fuzzy matching
      -- tiebreak by line no.
      ['--delimiter'] = vim.fn.shellescape(']'),
      ["--nth"]       = '2..',
      ["--tiebreak"]  = 'index',
    },
    actions = {
      ["default"]     = actions.buf_edit,
      ["ctrl-s"]      = actions.buf_split,
      ["ctrl-v"]      = actions.buf_vsplit,
      ["ctrl-t"]      = actions.buf_tabedit,
    }
  },
  blines = {
    previewer         = "builtin",    -- set to 'false' to disable
    show_unlisted     = true,         -- include 'help' buffers
    no_term_buffers   = false,        -- include 'term' buffers
    fzf_opts = {
      -- hide filename, tiebreak by line no.
      ['--delimiter'] = vim.fn.shellescape('[:]'),
      ["--with-nth"]  = '2..',
      ["--tiebreak"]  = 'index',
    },
    actions = {
      ["default"]     = actions.buf_edit,
      ["ctrl-s"]      = actions.buf_split,
      ["ctrl-v"]      = actions.buf_vsplit,
      ["ctrl-t"]      = actions.buf_tabedit,
    }
  },
  colorschemes = {
    live_preview      = true,
    actions           = { ["default"] = actions.colorscheme, },
    winopts           = { height = 0.55, width = 0.30, },
    post_reset_cb     = function()
      -- reset statusline highlights after
      -- a live_preview of the colorscheme
      -- require('feline').reset_highlights()
    end,
  },
  quickfix = {
    file_icons        = false,
    git_icons         = false,
  },
  lsp = {
		jump_to_single_result = true,
		sync = true,
    async_or_timeout  = 5000,
    cwd_only          = false,
    file_icons        = false,
    git_icons         = false,
    lsp_icons         = false,
    severity          = "hint",
    icons = {
      ["Error"]       = { icon = "", color = "red" },       -- error
      ["Warning"]     = { icon = "", color = "yellow" },    -- warning
      ["Information"] = { icon = "", color = "blue" },      -- info
      ["Hint"]        = { icon = "", color = "magenta" },   -- hint
    },
  },
  -- uncomment to disable the previewer
  -- nvim = { marks = { previewer = { _ctor = false } } },
  helptags = { previewer = { _ctor = false } },
  -- manpages = { previewer = { _ctor = false } },
  -- uncomment to set dummy win location (help|man bar)
  -- "topleft"  : up
  -- "botright" : down
  -- helptags = { previewer = { split = "topleft" } },
  -- uncomment to use `man` command as native fzf previewer
  manpages = { previewer = { _ctor = require'fzf-lua.previewer'.fzf.man_pages } },
  -- optional override of file extension icon colors
  -- available colors (terminal):
  --    clear, bold, black, red, green, yellow
  --    blue, magenta, cyan, grey, dark_grey, white
  -- padding can help kitty term users with
  -- double-width icon rendering
}

local map = require("config.utils").map
map("n", "<leader>ff", "<cmd>FzfLua files<cr>")
map("n", "<leader>fc", "<cmd>FzfLua files cwd=%:p:h<cr>")
map("n", "<leader>fh", "<cmd>FzfLua files cwd=~<cr>")
map("n", "<leader>fb", "<cmd>FzfLua buffers<cr>")
map("n", "<leader>gg", "<cmd>FzfLua live_grep<cr>")
map("n", "<leader>gc", "<cmd>FzfLua lgrep_curbuf<cr>")
map("n", "<leader>fa", "<cmd>FzfLua builtin<cr>")
map("n", "<leader>fr", "<cmd>FzfLua resume<cr>")
map("n", "<leader>fq", "<cmd>FzfLua quickfix<cr>")
map("n", "<leader>fj", "<cmd>FzfLua jumps<cr>")
map("n", "<leader>fo", "<cmd>FzfLua oldfiles<cr>")
map("n", "<leader>ft", "<cmd>FzfLua help_tags<cr>")
map("n", "<leader>fm", "<cmd>FzfLua keymaps<cr>")
