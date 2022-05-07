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

local function on_attach(client, bufnr)
  -- set up buffer keymaps, etc.
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

lspconfig.psalm.setup {
  capabilities = require('mrgeek.lsp.settings.psalm').capabilities,
  handlers = handlers,
  on_attach = require('mrgeek.lsp.settings.psalm').on_attach,
}

for _, server in ipairs { 'bashls', 'cssls', 'graphql', 'html', 'volar' } do
  lspconfig[server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers,
  }
end

-- -- set keymaps related to LSP
-- local function lsp_keymaps(bufnr)
--   local opts = { noremap = true, silent = true }
--
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<S-k>', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--   -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<S-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--   -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--   -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--   -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ border = \'rounded\' })<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next({ border = \'rounded\' })<CR>', opts)
--   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
--   vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting_sync()' ]]
-- end
--
-- -- this will highlight the current word under cursor
-- local function lsp_highlight_document(client)
--   -- Set autocommands conditional on server_capabilities
--   if client.resolved_capabilities.document_highlight then
--     vim.api.nvim_exec(
--       [[
--       augroup lsp_document_highlight
--         autocmd! * <buffer>
--         autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--         autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--       augroup END
--     ]],
--       false
--     )
--   end
-- end
--
-- on_attach = function(client, bufnr)
--   if client.name == 'tsserver' then
--     client.resolved_capabilities.document_formatting = false
--   end
--
--   lsp_keymaps(bufnr)
--   lsp_highlight_document(client)
-- end
