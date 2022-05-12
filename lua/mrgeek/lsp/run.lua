local lspconfig = require('lspconfig')

local function resolve_config(server_config)
  local defaults = require 'mrgeek.lsp'.get_common_opts()

  defaults = vim.tbl_deep_extend('force', defaults, server_config)

  return defaults
end

local function setup_server(server_name, server_config)
  lspconfig[server_name].setup(resolve_config(server_config))
end

local servers = {
  {
    name = 'eslint',
    setup = {
      on_attach = require('mrgeek.lsp.settings.eslint').on_attach,
      settings = require('mrgeek.lsp.settings.eslint').settings,
    }
  },
  {
    name = 'jsonls',
    setup = {
      on_attach = require('mrgeek.lsp.settings.eslint').on_attach,
      settings = require('mrgeek.lsp.settings.eslint').settings,
    }
  },
  {
    name = 'sumneko_lua',
    setup = {
      settings = require('mrgeek.lsp.settings.sumneko_lua').settings,
    }
  },
  {
    name = 'tsserver',
    setup = {
      capabilities = require('mrgeek.lsp.settings.tsserver').capabilities,
      on_attach = require('mrgeek.lsp.settings.tsserver').on_attach,
    }
  },
  {
    name = 'intelephense',
    setup = {
      root_dir = lspconfig.util.root_pattern('composer.json'),
      filetypes = { 'php' },
    }
  },
}

for _, server in ipairs(servers) do
  setup_server(server.name, server.setup)
end

for _, server in ipairs { 'bashls', 'cssls', 'html', 'phpactor', 'gopls' } do
  setup_server(server, {})
end
