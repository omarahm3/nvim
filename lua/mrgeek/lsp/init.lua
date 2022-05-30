local M = {}

local function add_lsp_buffer_keybindings(bufnr)
  local mappings = {
    normal_mode = 'n',
    insert_mode = 'i',
    visual_mode = 'v',
  }

  local status_ok, wk = pcall(require, 'which-key')

  if not status_ok then
    return
  end

  -- TODO use whick key for all keymappings
  for mode_name, mode_char in pairs(mappings) do
    wk.register(MrGeek.lsp.buffer_mappings[mode_name], { mode = mode_char, buffer = bufnr })
  end
end

function M.common_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
  capabilities.textDocument.completion.completionItem.preselectSupport = true
  capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
  capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
  capabilities.textDocument.completion.completionItem.deprecatedSupport = true
  capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
  capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    },
  }

  local present, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')

  if present then
    capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
  end

  return capabilities
end

function M.common_on_exit(_, _)
  if MrGeek.lsp.document_highlight then
    pcall(vim.api.nvim_del_augroup_by_name, 'lsp_document_highlight')
  end
  if MrGeek.lsp.code_lens_refresh then
    pcall(vim.api.nvim_del_augroup_by_name, 'lsp_code_lens_refresh')
  end
end

function M.common_on_init(_, _)

end

function M.common_on_attach(client, bufnr)
  local utils = require 'mrgeek.lsp.functions'

  if MrGeek.lsp.document_highlight then
    utils.setup_document_highlight(client, bufnr)
  end

  if MrGeek.lsp.code_lens_refresh then
    utils.setup_codelens_refresh(client, bufnr)
  end

  add_lsp_buffer_keybindings(bufnr)
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
  for _, sign in ipairs(MrGeek.lsp.diagnostics.signs.values) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  require 'mrgeek.lsp.handlers'.setup()

  require 'mrgeek.lsp.lsp-installer'

  require 'mrgeek.lsp.null-ls'.setup()

  require 'mrgeek.lsp.run'
  require 'mrgeek.lsp.functions'
end

return M
