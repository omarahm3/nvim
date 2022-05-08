local present, lsp_installer = pcall(require, 'nvim-lsp-installer')

if not present then
  vim.notify('nvim-lsp-installer does not exist')
  return
end

lsp_installer.setup {
  -- A list of servers to automatically install if they're not already installed
  ensure_installed = { 'bashls', 'cssls', 'eslint', 'html', 'jsonls', 'sumneko_lua', 'tsserver', 'psalm', 'gopls' },
  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed
  automatic_installation = true,
}
