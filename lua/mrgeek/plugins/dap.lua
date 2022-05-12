local present, plugin = pcall(require, 'dap')

if not present then
  return
end

local function configure()
  local _, dap_buddy = pcall(require, 'dap-install')

  dap_buddy.config('chrome', {})

  vim.fn.sign_define('DapBreakpoint', MrGeek.dap.breakpoint)
  vim.fn.sign_define('DapBreakpointRejected', MrGeek.dap.breakpoint_rejected)
  vim.fn.sign_define('DapStopped', MrGeek.dap.stopped)
end

local function configure_extensions()
  require('nvim-dap-virtual-text').setup({
    commented = true,
  })

  local dapui = require('dapui')

  dapui.setup({})

  plugin.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
  end
  plugin.listeners.after.event_terminated['dapui_config'] = function()
    dapui.close()
  end
  plugin.listeners.after.event_exited['dapui_config'] = function()
    dapui.close()
  end
end

local function configure_debuggers()
  require('mrgeek.dap.lua').setup()
  require('mrgeek.dap.go').setup()
end

local function configure_keymaps()
  local installed, whichkey = pcall(require, 'which-key')

  if not installed then
    vim.notify('unable to set dap keymaps since which key is not installed')
    return
  end

  local keymaps = {
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
  }

  whichkey.register(keymaps, {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  })

  local keymap_v = {
    name = "Debug",
    e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
  }
  whichkey.register(keymap_v, {
    mode = "v",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  })
end

configure()
configure_extensions()
configure_debuggers()
configure_keymaps()
