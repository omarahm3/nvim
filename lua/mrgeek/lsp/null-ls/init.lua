local M = {}

function M.setup()
  local present, null_ls = pcall(require, 'null-ls')

  if not present then
    vim.notify('null-ls is not installed')
    return
  end

  local b = null_ls.builtins

  local sources = {
    -- JS
    b.formatting.prettierd.with { filetypes = { 'html', 'markdown', 'css' } },
    b.formatting.eslint_d,
    b.diagnostics.eslint_d,

    -- PHP
    null_ls.builtins.diagnostics.php,
    null_ls.builtins.diagnostics.phpcs.with({
      command = './bin/phpcs',
      args = {
        "--standard=./ruleset.xml",
        -- "src/"
      }
    }),

    -- Vale
    require("null-ls").builtins.diagnostics.vale,

    -- GIT
    null_ls.builtins.code_actions.gitsigns,

    -- Go
    null_ls.builtins.diagnostics.golangci_lint,

    -- Lua
    b.formatting.stylua,
    b.diagnostics.luacheck.with { extra_args = { '--global vim' } },

    -- Shell
    b.formatting.shfmt,
    b.diagnostics.shellcheck.with { diagnostics_format = '#{m} [#{c}]' },
  }

  local default_opts = require 'mrgeek.lsp'.get_common_opts()

  null_ls.setup(vim.tbl_deep_extend('force', default_opts, {
    debug = true,
    sources = sources,
  }))
end

return M
