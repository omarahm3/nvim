local present, lspconfig = pcall(require, 'lspconfig')

if not present then
  vim.notify('LspConfig does not exist')
  return
end

local config = {
  virtual_text = false,
  signs = {
    active = signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    source = false,
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
        for _, table in pairs(codes) do
          if vim.tbl_contains(table, code) then
            return string.format('%s [%s]', table.icon .. diagnostic.message, code)
          end
        end

        return string.format('%s [%s]', diagnostic.message, code)
      end

      return string.format('%s [%s]', diagnostic.message, diagnostic.source)
    end
  },
}

vim.diagnostic.config(config)

-- UI

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texth1 = sign.name, text = sign.text, numh1 = "" })
end

require 'mrgeek.lsp.lsp-installer'
require 'mrgeek.lsp.run'






























