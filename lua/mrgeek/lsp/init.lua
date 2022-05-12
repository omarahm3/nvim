local present, _ = pcall(require, 'lspconfig')

if not present then
  vim.notify('LspConfig does not exist')
  return
end

local signs = {
  { name = "Error", text = "" },
  { name = "Warn", text = "" },
  { name = "Hint", text = "" },
  { name = "Info", text = "" },
}

local function lspSymbol(name, icon)
  local hl = "DiagnosticSign" .. name
  vim.fn.sign_define(hl, {
    text = icon,
    numh1 = hl,
    texthl = hl,
  })
end

for _, row in ipairs(signs) do
  lspSymbol(row.name, row.text)
end

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

-- suppress error messages from lang servers
vim.notify = function(msg, log_level)
  if msg:match "exit code" then
    return
  end
  if log_level == vim.log.levels.ERROR then
    vim.api.nvim_err_writeln(msg)
  else
    vim.api.nvim_echo({ { msg } }, true, {})
  end
end

require 'mrgeek.lsp.lsp-installer'
require 'mrgeek.lsp.run'
require 'mrgeek.lsp.functions'
