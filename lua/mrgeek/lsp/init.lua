local M = {}

function M.common_on_attach()
  local utils = require 'mrgeek.lsp.functions'
  utils.setup_document_highlight()
end

function M.get_common_opts()
  return {
    on_attach = M.common_on_attach,
    on_init = M.common_on_init,
    on_exit = M.common_on_exit,
    capabilities = M.common_capabilities(),
  }
end

function M.setup()
  local present, _ = pcall(require, 'lspconfig')

  if not present then
    vim.notify('LspConfig does not exist')
    return
  end

  -- UI stuff

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

  require 'mrgeek.lsp.handlers'.setup()

  require 'mrgeek.lsp.lsp-installer'

  require 'mrgeek.lsp.null-ls'

  require 'mrgeek.lsp.run'
  require 'mrgeek.lsp.functions'
end

return M
