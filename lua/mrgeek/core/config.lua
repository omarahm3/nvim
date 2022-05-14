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
    globalopts = {
      mode = 'n', -- NORMAL mode
      prefix = '',
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
    },
    vglobalopts = {
      mode = 'v', -- VISUAL mode
      prefix = '',
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
    },
    tglobalopts = {
      mode = 't', -- TERMINAL mode
      prefix = '',
      silent = true, -- use `silent` when creating keymaps
    },
    vglobalmappings = {
      ['<S-Tab>'] = { '<gv', 'Indent left' },
      ['<Tab>'] = { '>gv', 'Indent right' },
      ['p'] = { '"_dP', 'Keep what you are pasting in the clipboard register' },
    },
    terminal_globalmappings = {
      ['<C-h>'] = { '<C-\\><C-N><C-w>h', 'Teminal left' },
      ['<C-j>'] = { '<C-\\><C-N><C-w>j', 'Teminal down' },
      ['<C-k>'] = { '<C-\\><C-N><C-w>k', 'Teminal up' },
      ['<C-l>'] = { '<C-\\><C-N><C-w>l', 'Teminal right' },
    },
    globalmappings = {
      ['<ESC>'] = { ':noh<CR>', 'No highlight' },
      ['<C-s>'] = { ':w!<CR>', 'Save file' },
      ['<Tab>'] = { ':BufferLineCycleNext<CR>', 'Next' },
      ['<S-Tab>'] = { ':BufferLineCyclePrev<CR>', 'Previous' },
      ['<F8>'] = { ':SymbolsOutline<CR>', 'Symbols outline' },
      ['<C-Up>'] = { ':resize -2<CR>', 'Resize window up' },
      ['<C-Down>'] = { ':resize +2<CR>', 'Resize window down' },
      ['<C-Left>'] = { ':vertical resize -2<CR>', 'Resize window left' },
      ['<C-Right>'] = { ':vertical resize +2<CR>', 'Resize window right' },
      ['<C-h>'] = { '<C-w>h', 'Move window left' },
      ['<C-j>'] = { '<C-w>j', 'Move window down' },
      ['<C-k>'] = { '<C-w>k', 'Move window up' },
      ['<C-l>'] = { '<C-w>l', 'Move window right' },
      ['<C-p>'] = { ':Telescope find_files<CR>', 'Find file' },
    },
    vkeymappings = {
      ['/'] = { ':lua require"Comment.api".toggle_current_linewise_op(vim.fn.visualmode())<CR>', 'Comment' },
      g = {
        h = { ':lua require "gitsigns".stage_hunk()<CR>', 'Stage hunk' },
      },
      y = {
        name = 'Focus',
        c = { ':YodeCreateSeditorFloating<CR>', 'Yoda create' },
        r = { ':YodeCreateSeditorReplace<CR>', 'Yoda replace' },
      }
    },
    keymappings = {
      ['w'] = { ':w!<CR>', 'Save file' },
      ['x'] = { ':lua require("mrgeek.utils").close_buffer()<CR>', 'Close current buffer' },
      ['/'] = { ':lua require"Comment.api".toggle_current_linewise()<CR>', 'Comment line' },
      ['e'] = { ':NvimTreeToggle<CR>', 'NvimTree toggle' },
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
        i = { ':LspInfo<CR>', 'Info' },
        I = { ':LspInstallInfo<CR>', 'Install info' },
        j = { ':lua vim.diagnostic.goto_next()<CR>', 'Next diagnostic' },
        k = { ':lua vim.diagnostic.goto_prev()<CR>', 'Previous diagnostic' },
        l = { ':lua vim.lsp.codelens.run()<CR>', 'CodeLens action' },
        p = {
          name = 'Peek',
          d = { '<cmd>lua require("mrgeek.lsp.peek").Peek("definition")<CR>', "Definition" },
          t = { '<cmd>lua require("mrgeek.lsp.peek").Peek("typeDefinition")<CR>', "Type definition" },
          i = { '<cmd>lua require("mrgeek.lsp.peek").Peek("implementation")<CR>', "Implementation" },
        },
        q = { ':lua vim.diagnostic.setloclist()<CR>', 'Quickfix' },
        r = { ':lua vim.lsp.buf.rename()<CR>', 'Rename' },
        s = { ':Telescope lsp_document_symbols<CR>', 'Document symbols' },
        S = { ':Telescope lsp_dynamic_workspace_symbols<CR>', 'Workspace symbols' },
        e = { ':Telescope quickfix<CR>', 'Telescope quickfix' },
      },
      f = {
        name = 'Find',
        b = { ':Telescope git_branches<CR>', 'Checkout branch' },
        c = { ':lua require("telescope.builtin.internal").colorscheme({enable_preview = true})<CR>', 'Colorscheme' },
        f = { ':Telescope find_files<CR>', 'Find file' },
        h = { ':Telescope help_tags<CR>', 'Find help' },
        M = { ':Telescope man_pages<CR>', 'Man pages' },
        o = { ':Telescope oldfiles<CR>', 'Open recent files' },
        r = { ':lua require"telescope".extensions.repo.list{fd_opts={"--no-ignore-vcs"}}<CR>', 'Open repositories' },
        R = { ':Telescope registers<CR>', 'Registers' },
        w = { ':Telescope live_grep<CR>', 'Text' },
        k = { ':Telescope keymaps<CR>', 'Keymaps' },
        C = { ':Telescope commands<CR>', 'Commands' },
      },
      t = {
        name = 'Terminal',
        f = { ':ToggleTerm direction=float<CR>', 'Float' },
        h = { ':ToggleTerm size=10 direction=horizontal<CR>', 'Horizontal' },
        v = { ':ToggleTerm size=80 direction=vertical<CR>', 'Vertical' },
        n = { ':lua _NODE_TOGGLE()<CR>', 'Node' },
        t = { ':lua _HTOP_TOGGLE()<CR>', 'HTOP' },
        g = { ':lua _GORE_TOGGLE()<CR>', 'Gore' },
        l = { ':lua _LAZYGIT_TOGGLE()<CR>', 'Lazygit' },
      },
      j = {
        name = 'Jest',
        t = { ':lua require("jester").run()<CR>', 'Run test' },
        f = { ':lua require("jester").run_file()<CR>', 'Run file' },
        l = { ':lua require("jester").run_last()<CR>', 'Run last' },
        d = {
          name = 'Debug',
          t = { ':lua require("jester").debug()<CR>', 'Debug test' },
          f = { ':lua require("jester").debug_file()<CR>', 'Debug file' },
          l = { ':lua require("jester").debug_last()<CR>', 'Debug last' },
        }
      },
      y = {
        name = 'Focus',
        t = { ':Twilight<CR>', 'Twilight' },
        d = { ':YodeBufferDelete<CR>', 'Yoda delete buffer' },
      },
    }
  }
}
