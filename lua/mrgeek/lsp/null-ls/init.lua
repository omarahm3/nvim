local log = require("mrgeek.core.log")
local M = {}

function M.setup()
  local present, null_ls = pcall(require, "null-ls")

  if not present then
    log:error("null-ls does not exist")
    return
  end

  local b = null_ls.builtins

  local sources = {
    -- JS
    b.formatting.eslint,
    b.diagnostics.eslint,
    b.code_actions.eslint,

    b.formatting.prettier.with({
      filetypes = {
        -- "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "css",
        "scss",
        "less",
        "html",
        "json",
        "jsonc",
        "yaml",
        "markdown",
      },
      --[[ extra_args = { ]]
      --[[   "--config", ]]
      --[[   vim.fn.expand("~/.node-style-rules/.prettierrc.json"), ]]
      --[[ }, ]]
    }),

    -- PHP
    b.diagnostics.php,
    b.diagnostics.phpcs.with({
      command = vim.fn.expand("~/.config/composer/vendor/bin/phpcs"),
      extra_args = {
        "--standard=./ruleset.xml",
        -- "src/"
      },
    }),

    -- fish
    b.diagnostics.fish,

    -- Spell check
    b.diagnostics.codespell,

    -- Vale
    b.diagnostics.vale.with({
      extra_args = {
        "--config",
        vim.fn.expand("~/.config/vale/vale.ini")
      }
    }),

    -- Python
    b.diagnostics.pylint.with({
      diagnostics_postprocess = function(diagnostic)
        diagnostic.code = diagnostic.message_id
      end,
    }),
    b.formatting.isort,
    b.formatting.black,

    -- GIT
    b.code_actions.gitsigns,

    -- Go
    b.diagnostics.golangci_lint,

    -- Lua
    b.formatting.stylua,
    b.diagnostics.luacheck.with({ extra_args = { "--global vim" } }),

    -- Shell
    b.formatting.shfmt,
    b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),
    b.code_actions.shellcheck,
  }

  local default_opts = require("mrgeek.lsp").get_common_opts()

  null_ls.setup(vim.tbl_deep_extend("force", default_opts, {
    debug = false,
    sources = sources,
    on_attach = function(client, bufnr)
    end,
  }))
end

return M
