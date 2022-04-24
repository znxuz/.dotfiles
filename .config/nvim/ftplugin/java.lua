if pcall(function () require('jdtls') end) == false then
return
end

local map = require('config.utils').map
map('n', '<leader>ci', '<cmd>lua require("jdtls").organize_imports()<cr>')
map('i', '<leader>ci', '<cmd>lua require("jdtls").organize_imports()<cr>')

local workspace_dir = vim.env.HOME .. '/.local/share/workspace/'
local config = {
	cmd = {'java-lsp',
	workspace_dir .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
},
root_dir = require('jdtls.setup').find_root({'gradle.build', 'pom.xml'}),
settings = {
	java = {
		project = {
			referencedLibraries = {
				'/usr/lib/jvm/java-11-openjfx/lib/javafx.base.jar',
				'/usr/lib/jvm/java-11-openjfx/lib/javafx.controls.jar',
				'/usr/lib/jvm/java-11-openjfx/lib/javafx.graphics.jar'
			}
		}
	}
}
}
require('jdtls').start_or_attach(config)
