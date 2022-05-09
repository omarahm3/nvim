local lspconfig = require('lspconfig')

local handlers = {
  ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
  ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
local present, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')


if present then
  capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
end

local function on_attach(client, _)
  -- set up buffer keymaps, etc.
  require('mrgeek.lsp.functions').lsp_highlight_document(client)
end

lspconfig.eslint.setup {
  capabilities = capabilities,
  handlers = handlers,
  on_attach = require('mrgeek.lsp.settings.eslint').on_attach,
  settings = require('mrgeek.lsp.settings.eslint').settings,
}

lspconfig.jsonls.setup {
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
  settings = require('mrgeek.lsp.settings.jsonls').settings,
}

lspconfig.sumneko_lua.setup {
  handlers = handlers,
  on_attach = on_attach,
  settings = require('mrgeek.lsp.settings.sumneko_lua').settings,
}

lspconfig.tsserver.setup {
  capabilities = require('mrgeek.lsp.settings.tsserver').capabilities,
  handlers = handlers,
  on_attach = require('mrgeek.lsp.settings.tsserver').on_attach,
}

lspconfig.intelephense.setup {
  on_attach = on_attach,
  handlers = handlers,
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern('composer.json'),
  filetypes = { 'php' },
}

lspconfig.phpactor.setup {
  on_attach = on_attach,
  handlers = handlers,
  capabilities = capabilities,
}

-- lspconfig.psalm.setup {
--   root_dir = lspconfig.util.root_pattern('composer.json'),
--   filetypes = { 'php' },
-- }

lspconfig.gopls.setup {
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
}

for _, server in ipairs { 'bashls', 'cssls', 'html' } do
  lspconfig[server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers,
  }
end
