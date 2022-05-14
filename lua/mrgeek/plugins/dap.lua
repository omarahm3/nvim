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

configure()
configure_extensions()
configure_debuggers()
