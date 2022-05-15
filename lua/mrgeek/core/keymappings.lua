local mappings = {
  opts = {
    mode = 'n', -- NORMAL mode
    prefix = MrGeek.default_leader,
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  },
  vopts = {
    mode = 'v', -- VISUAL mode
    prefix = MrGeek.default_leader,
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
    ['f'] = { ':lua require"hop".hint_words()<cr>', 'Hop words' },
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
    },
    d = {
      name = "Debug",
      e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
    },
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
    d = {
      name = "Debug",
      R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
      E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
      C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
      U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
      b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
      c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
      d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
      e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
      g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
      h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
      S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
      i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
      o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
      p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
      q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
      r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
      s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
      t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
      x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
      u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
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
      a = { ':TZAtaraxis<CR>', 'Ataraxis mode' },
      f = { ':TZFocus<CR>', 'Focus mode' },
      m = { ':TZMinimalist<CR>', 'Focus mode' },
    },
  }
}

MrGeek.mappings = mappings
