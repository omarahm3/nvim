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
    "bash-language-server",
    "css-lsp",
    "html-lsp",
    "json-lsp",
    "lua-language-server",
    "eslint-lsp",
    "tailwindcss-language-server",
    "typescript-language-server",
    "chrome-debug-adapter",
    "node-debug2-adapter",
    "intelephense",
    "gopls",
    "pyright",
  },
  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed
  automatic_installation = true,
})
