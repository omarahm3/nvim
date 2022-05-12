local lspconfig = require('lspconfig')

local function resolve_config(server_config)
  local defaults = require 'mrgeek.lsp'.get_common_opts()

  defaults = vim.tbl_deep_extend('force', defaults, server_config)

  return defaults
end

local function setup_server(server_name, server_config)
  lspconfig[server_name].setup(resolve_config(server_config))
end

setup_server('eslint', {
  on_attach = require('mrgeek.lsp.settings.eslint').on_attach,
  settings = require('mrgeek.lsp.settings.eslint').settings,
})

setup_server('jsonls', {
  settings = require('mrgeek.lsp.settings.jsonls').settings,
})

setup_server('sumneko_lua', {
  settings = require('mrgeek.lsp.settings.sumneko_lua').settings,
})

setup_server('tsserver', {
  capabilities = require('mrgeek.lsp.settings.tsserver').capabilities,
  on_attach = require('mrgeek.lsp.settings.tsserver').on_attach,
})

setup_server('intelephense', {
  root_dir = lspconfig.util.root_pattern('composer.json'),
  filetypes = { 'php' },
})

for _, server in ipairs { 'bashls', 'cssls', 'html', 'phpactor', 'gopls' } do
  setup_server(server, {})
end
