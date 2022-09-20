local autocmd = vim.api.nvim_create_autocmd

-- autocommand that will reload neovim whenever you save plugins.lua file
autocmd("BufWritePost", { pattern = "plugins.lua", command = "source <afile> | PackerSync" })
-- Highlight on yank
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})
-- Format go files on save
autocmd("BufWritePre", { pattern = "*.go", command = ":silent! lua require('go.format').goimport()" })
-- Detect ansible files
autocmd("BufRead", {
  pattern = { "*.yaml", "*.yml" },
  callback = function()
    if vim.fn.search("hosts:\\|tasks:", "nw") then
      vim.api.nvim_command("set ft=yaml.ansible")
    end
  end,
})
