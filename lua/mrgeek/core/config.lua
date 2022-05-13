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
    name = 'rose-pine',
    lualine = 'rose-pine',
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
        ['<leader>cr'] = { vim.lsp.buf.rename, 'Check code action' },
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
  mappings = {
    opts = {
      mode = 'n', -- NORMAL mode
      prefix = '<leader>',
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
    },
    vopts = {
      mode = 'v', -- VISUAL mode
      prefix = '<leader>',
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
    },
    keymappings = {
      ['w'] = { ':w!<CR>', 'Save file' },
      ['x'] = { ':lua require("mrgeek.utils").close_buffer()<CR>', 'Close current buffer' },

      -- Buffers related
      -- TODO Check how to register global keymappings without holding to leader
      -- ['<ESC>'] = { ':noh<CR>', 'No highlight' },
      -- ['jk'] = { '<ESC>', 'Escape insert mode and go to visual mode' },
      -- ['<C-s>'] = { ':w!<CR>', 'Save file' },
      -- ['<Tab>'] = { ':BufferLineCycleNext<CR>', 'Next' },
      -- ['<S-Tab>'] = { ':BufferLineCyclePrev<CR>', 'Previous' },

      b = {
        name = 'Buffers',
        j = { ':BufferLinePick<CR>', 'Jump' },
        f = { ':Telescope buffers<CR>', 'Find' },
        p = { ':BufferLineCyclePrev<CR>', 'Previous' },
        n = { ':BufferLineCycleNext<CR>', 'Next' },
        e = { ':BufferLinePickClose<CR>', 'Pick buffer to close' },
        D = { ':BufferLineSortByDirectory<CR>', 'Sort by directory' },
        L = { ':BufferLineSortByExtension<CR>', 'Sort by language' },
      },
      s = {
        name = 'Session',
        s = { ':SessionSave<CR>', 'Save session' },
        l = { ':SessionLoad<CR>', 'Load session' },
      },
      g = {
        name = 'Git',
        j = { ':lua require "gitsigns".next_hunk()<CR>', 'Next hunk' },
        k = { ':lua require "gitsigns".prev_hunk()<CR>', 'Previous hunk' },
        l = { ':lua require "gitsigns".blame_line({full=true})<CR>', 'Blame line' },
        B = { ':0Gclog<CR>', 'Blame file' },
        p = { ':lua require "gitsigns".preview_hunk()<CR>', 'Preview hunk' },
        r = { ':lua require "gitsigns".reset_hunk()<CR>', 'Reset hunk' },
        R = { ':lua require "gitsigns".reset_buffer()<CR>', 'Reset buffer' },
        h = { ':lua require "gitsigns".stage_hunk()<CR>', 'Stage hunk' },
        u = { ':lua require "gitsigns".undo_stage_hunk()<CR>', 'Undo stage hunk' },
        s = { ':G<CR>', 'Status' },
        b = { ':Telescope git_branches<CR>', 'Checkout branch' },
        c = { ':Telescope git_branches<CR>', 'Checkout branch' },
        d = { ':lua require "gitsigns".diffthis("~")<CR>', 'Diff current file with remote' },
        L = { ':lua _LAZYGIT_TOGGLE()<CR>', 'LazyGit' },
        t = {
          name = 'Toggle',
          l = { ':lua require "gitsigns".toggle_current_line_blame()<CR>', 'Blame line' },
          d = { ':lua require "gitsigns".toggle_deleted()<CR>', 'Deleted hunks' },
        },
        v = {
          name = 'Diff View',
          o = { ':DiffviewOpen -uno<CR>', 'Open' },
          c = { ':DiffviewClose<CR>', 'Close' },
          r = { ':DiffviewRefresh<CR>', 'Refresh' },
          f = { ':DiffviewToggleFiles<CR>', 'Toggle files' },
          s = { ':DiffviewFocusFiles<CR>', 'Focus files' },
          h = { ':DiffviewFileHistory %:p<CR>', 'File history' },
        }
      },
      l = {
        name = 'LSP',
        a = { ':lua vim.lsp.buf.code_action()<CR>', 'Code action' },
        d = { ':Telescope diagnostics bufnr=0 theme=get_ivy<CR>', 'Buffer diagnostics' },
        w = { ':Telescope diagnostics<CR>', 'Diagnostics' },
        f = { ':lua require"mrgeek.lsp.functions".format()<CR>', 'Format' },
      }
    }
  }
}
