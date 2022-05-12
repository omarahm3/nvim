local M = {}

function M.setup()
  local config = {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
      format = function(diagnostic)
        local code = diagnostic.user_data.lsp.code

        if not diagnostic.source or not code then
          return string.format('%s', diagnostic.message)
        end

        if diagnostic.source == 'eslint' then
          return string.format('%s [%s]', diagnostic.message, code)
        end

        return string.format('%s [%s]', diagnostic.message, diagnostic.source)
      end
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
end

return M
