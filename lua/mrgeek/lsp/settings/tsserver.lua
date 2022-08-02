local M = {}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}
capabilities.textDocument.codeAction = {
  dynamicRegistration = false,
  codeActionLiteralSupport = {
    codeActionKind = {
      valueSet = {
        '',
        'quickfix',
        'refactor',
        'refactor.extract',
        'refactor.inline',
        'refactor.rewrite',
        'source',
        'source.organizeImports',
      },
    },
  },
}

local default_capabilities = require('mrgeek.lsp').common_capabilities()

local on_attach = function(client, bufnr)
  require('mrgeek.lsp').common_on_attach(client, bufnr)
  client.server_capabilities.documentRangeFormattingProvider = false
  client.server_capabilities.documentFormattingProvider = false

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  require('nvim-lsp-ts-utils').setup {
    debug = false,
    disable_commands = false,
    enable_import_on_completion = true,
    import_all_timeout = 5000, -- ms

    -- formatting
    enable_formatting = false,
    formatter = 'eslint',
    formatter_config_fallback = nil,

    -- parentheses completion
    complete_parens = false,
    signature_help_in_parens = false,

    -- update imports on file move
    update_imports_on_move = true,
    require_confirmation_on_move = true,
    watch_dir = nil,

    -- filter diagnostics
    -- filter_out_diagnostics_by_severity = { 'hint' },
    -- filter_out_diagnostics_by_code = {},
  }

  require('nvim-lsp-ts-utils').setup_client(client)
end

M.capabilities = vim.tbl_deep_extend('force', capabilities, default_capabilities);
M.on_attach = on_attach;

return M
