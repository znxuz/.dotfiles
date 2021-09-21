set shortmess+=c
set signcolumn=yes
set completeopt=menuone,noinsert,noselect

" nvim-cmp
lua << EOF
local cmp = require 'cmp'

cmp.setup {
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-y>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  },
  sources = { { name = 'nvim_lsp' }, },
}
EOF

" keybinds
	nnoremap <silent> gD <CMD>lua vim.lsp.buf.declaration()<CR>
	nnoremap <silent> gh <CMD>lua vim.lsp.buf.hover()<CR>
	nnoremap <silent> gd <CMD>Telescope lsp_definitions<CR>
	nnoremap <silent> gp <CMD>Telescope lsp_implementations<CR>
	nnoremap <silent> gr <CMD>Telescope lsp_references<CR>
	inoremap <silent> <leader>gh <CMD>lua vim.lsp.buf.signature_help()<CR>
	nnoremap <silent> <leader>gre <CMD>lua vim.lsp.buf.rename()<CR>
	nnoremap <silent> <leader>fss <CMD>Telescope lsp_dynamic_workspace_symbols<CR>
	nnoremap <silent> <leader>fsc <CMD>Telescope lsp_document_symbols<CR>
	nnoremap <silent> <leader>gee <CMD>Telescope lsp_workspace_diagnostics<CR>
	nnoremap <silent> <leader>gec <CMD>Telescope lsp_document_diagnostics<CR>
	nnoremap <silent> <leader>gen <CMD>lua vim.lsp.diagnostic.goto_prev()<CR>
	nnoremap <silent> <leader>gep <CMD>lua vim.lsp.diagnostic.goto_next()<CR>

" language servers https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md

" C
	let g:c_syntax_for_h = 1
	lua require('lspconfig').clangd.setup{}
	nnoremap <silent> <leader>s :ClangdSwitchSourceHeader<CR>

" Lua
lua << EOF
USER = vim.fn.expand('$USER')
local sumneko_root_path = ""
local sumneko_binary = ""
if vim.fn.has("unix") == 1 then
	sumneko_root_path = "/usr/share/lua-language-server"
	sumneko_binary = "/usr/bin/lua-language-server"
else
	print("Unsupported system for sumneko")
end
require'lspconfig'.sumneko_lua.setup {
	cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
				path = vim.split(package.path, ';')
			},
			diagnostics = { globals = {'vim'} },
			workspace = { library = vim.api.nvim_get_runtime_file("", true), },
			telemetry = { enable = false },
		},
	},
}
EOF

" Java
	if has('nvim-0.5')
	  augroup lsp
		au!
		au FileType java lua require('jdtls').start_or_attach({cmd = {'java-lsp'}, root_dir = require('jdtls.setup').find_root({'.git', 'gradle.build', 'pom.xml', 'Makefile', 'makefile'})})
	  augroup end
	endif

	nnoremap <leader>ca <CMD>lua require('jdtls').code_action()<CR>
	vnoremap <leader>ca <ESC><CMD>lua require('jdtls').code_action(true)<CR>
	nnoremap <leader>cr <CMD>lua require('jdtls').code_action(false, 'refactor')<CR>

	nnoremap <leader>co <CMD>lua require('jdtls').organize_imports()<CR>
	" <CMD>lua require('jdtls').extract_variable()<CR>
	" <ESC><CMD>lua require('jdtls').extract_variable(true)<CR>
	" <CMD>lua require('jdtls').extract_constant()<CR>
	" <ESC><CMD>lua require('jdtls').extract_constant(true)<CR>
	" <ESC><CMD>lua require('jdtls').extract_method(true)<CR>

lua << EOF
local finders = require'telescope.finders'
local sorters = require'telescope.sorters'
local actions = require'telescope.actions'
local pickers = require'telescope.pickers'
require('jdtls.ui').pick_one_async = function(items, prompt, label_fn, cb)
  local opts = {}
  pickers.new(opts, {
    prompt_title = prompt,
    finder    = finders.new_table {
      results = items,
      entry_maker = function(entry)
        return {
          value = entry,
          display = label_fn(entry),
          ordinal = label_fn(entry),
        }
      end,
    },
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = actions.get_selected_entry(prompt_bufnr)
        actions.close(prompt_bufnr)

        cb(selection.value)
      end)

      return true
    end,
  }):find()
end
EOF
