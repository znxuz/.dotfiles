vim.cmd 'setl et'

if pcall(function () require('jdtls') end) == false then
  return
end

require('config.mapper').map('n', '<leader>ao', function () require("jdtls").organize_imports() end)

local xdg_data_home = os.getenv('XDG_DATA_HOME')
local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', xdg_data_home .. '/jdtls/plugins/org.eclipse.equinox.launcher_1.6.500.v20230622-2056.jar',
    '-configuration', xdg_data_home .. '/jdtls/config_linux',
    '-data', xdg_data_home .. '/nvim/jdtls/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  },

  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),

  settings = {
    java = {
      project = {
	referencedLibraries = {
          vim.fn.getcwd() .. '/lib/**/*.jar',
	}
      }
    }
  }
}
require('jdtls').start_or_attach(config)
