local lspconfig = require('lspconfig')

local M = {}

M.settings = {
  root_dir = lspconfig.util.root_pattern('composer.json'),
}

return M
