local float = {
  style = 'minimal',
  border = 'rounded',
  source = 'always',
  header = '',
  prefix = '',
  focusable = false,
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
}

return {
  diagnostics = {
    signs = {
      active = true,
      values = {
        { name = 'DiagnosticSignError', text = '' },
        { name = 'DiagnosticSignWarn', text = '' },
        { name = 'DiagnosticSignHint', text = '' },
        { name = 'DiagnosticSignInfo', text = '' },
      },
    },
    virtual_text = false,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = float,
  },
  document_highlight = true,
  code_lens_refresh = true,
  float = {
    focusable = true,
    style = 'minimal',
    border = 'rounded',
  },
  peek = {
    max_height = 15,
    max_width = 30,
    context = 30,
  },
  automatic_servers_installation = true,
  buffer_mappings = {
    normal_mode = {
      ['K'] = { vim.lsp.buf.hover, 'Show hover' },
      ['gd'] = { vim.lsp.buf.definition, 'Goto Definition' },
      ['gD'] = { vim.lsp.buf.declaration, 'Goto declaration' },
      ['gr'] = { vim.lsp.buf.references, 'Goto references' },
      ['gI'] = { vim.lsp.buf.implementation, 'Goto Implementation' },
      ['gs'] = { vim.lsp.buf.signature_help, 'show signature help' },
      ['gp'] = {
        function()
          require('mrgeek.lsp.peek').Peek 'definition'
        end,
        'Peek definition',
      },
      ['gl'] = {
        function()
          local config = float
          config.scope = 'line'
          vim.diagnostic.open_float(0, config)
        end,
        'Show line diagnostics',
      },
    },
    insert_mode = {},
    visual_mode = {},
  },
}
