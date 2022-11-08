local M = {}

function M.setup()
  local present, null_ls = pcall(require, "null-ls")

  if not present then
    vim.notify("null-ls does not exist")
    return
  end

  local b = null_ls.builtins

  local sources = {
    -- JS
    b.diagnostics.tsc,
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

    -- Ansible
    b.diagnostics.ansiblelint,

    -- All
    b.formatting.trim_whitespace,
    b.diagnostics.todo_comments,
  }

  local default_opts = require("mrgeek.lsp").get_common_opts()

  null_ls.setup(vim.tbl_deep_extend("force", default_opts, {
    debug = false,
    sources = sources,
    on_attach = function(client, bufnr) end,
  }))
end

return M
