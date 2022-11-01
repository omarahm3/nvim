local mason_present, mason = pcall(require, "mason")
local mason_lsp_present, mason_lsp = pcall(require, "mason-lspconfig")

if not mason_present or not mason_lsp_present then
  vim.notify("mason or mason_lsp does not exist")
  return
end

mason.setup({
  ui = {
    border = "rounded",
  },
})

mason_lsp.setup({
  -- A list of servers to automatically install if they're not already installed
  ensure_installed = {
    "bashls",
    "ansiblels",
    "cssls",
    "html",
    "jsonls",
    "sumneko_lua",
    "eslint",
    "tailwindcss",
    "tsserver",
    "intelephense",
    "gopls",
    "pyright",
  },
  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed
  automatic_installation = true,
})
