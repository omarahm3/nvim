local icons = require('mrgeek.core.icons')

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

MrGeek = {
  log = {
    level = 'debug',
  },
  icons = icons,
  theme = {
    name = 'catppuccin',
    lualine = 'catppuccin',
  },
  lsp = {
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
    buffer_mappings = {
      normal_mode = {
        ['K'] = { vim.lsp.buf.hover, 'Show hover' },
        ['gd'] = { vim.lsp.buf.definition, 'Goto Definition' },
        ['gD'] = { vim.lsp.buf.declaration, 'Goto declaration' },
        ['gr'] = { ':TroubleToggle lsp_references<CR>', 'Goto references' },
        ['gI'] = { vim.lsp.buf.implementation, 'Goto Implementation' },
        ['gs'] = { vim.lsp.buf.signature_help, 'show signature help' },
        ['<leader>cf'] = { vim.lsp.buf.formatting, 'Format whole file' },
        ['<leader>ca'] = { vim.lsp.buf.code_action, 'Check code action' },
        ['<leader>cr'] = { vim.lsp.buf.rename, 'Rename' },
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
      visual_mode = {
        ['<leader>cf'] = { vim.lsp.buf.range_formatting, 'Format a code block' },
        ['<leader>ca'] = { vim.lsp.buf.range_code_action, 'Code block code action' },
      },
    },
  },
  dap = {
    on_config_done = nil,
    breakpoint = {
      text = '',
      texthl = 'LspDiagnosticsSignError',
      linehl = '',
      numhl = '',
    },
    breakpoint_rejected = {
      text = '',
      texthl = 'LspDiagnosticsSignHint',
      linehl = '',
      numhl = '',
    },
    stopped = {
      text = '',
      texthl = 'LspDiagnosticsSignInformation',
      linehl = 'DiagnosticUnderlineInfo',
      numhl = 'LspDiagnosticsSignInformation',
    },
  },
  default_leader = '<Space>',
  mappings = {},
}
