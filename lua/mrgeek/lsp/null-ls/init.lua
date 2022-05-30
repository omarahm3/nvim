local log = require "mrgeek.core.log"
local M = {}

function M.setup()
  local present, null_ls = pcall(require, 'null-ls')

  if not present then
    log:error('null-ls does not exist')
    return
  end

  local b = null_ls.builtins

  local sources = {
    -- JS
    b.formatting.eslint,

    -- PHP
    b.diagnostics.php,
    b.diagnostics.phpcs.with({
      command = './bin/phpcs',
      args = {
        "--standard=./ruleset.xml",
        -- "src/"
      }
    }),

    -- fish
    b.diagnostics.fish,

    -- Spell check
    b.diagnostics.codespell,

    -- Vale
    b.diagnostics.vale,

    -- GIT
    b.code_actions.gitsigns,

    -- Go
    b.diagnostics.golangci_lint,

    -- Lua
    b.formatting.stylua,
    b.diagnostics.luacheck.with { extra_args = { '--global vim' } },

    -- Shell
    b.formatting.shfmt,
    b.diagnostics.shellcheck.with { diagnostics_format = '#{m} [#{c}]' },
    b.code_actions.shellcheck,
  }

  local default_opts = require 'mrgeek.lsp'.get_common_opts()

  null_ls.setup(vim.tbl_deep_extend('force', default_opts, {
    debug = true,
    sources = sources,
  }))
end

return M
