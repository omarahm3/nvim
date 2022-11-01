local log = require("mrgeek.core.log")
local M = {}

function M.setup()
  local present, null_ls = pcall(require, "null-ls")

  if not present then
    log:error("null-ls does not exist")
    return
  end

  local b = null_ls.builtins

  local async_formatting = function(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    vim.lsp.buf_request(
      bufnr,
      "textDocument/formatting",
      { textDocument = { uri = vim.uri_from_bufnr(bufnr) } },
      function(err, res, ctx)
        if err then
          -- local err_msg = type(err) == "string" and err or err.message
          -- vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
          return
        end

        -- don't apply results if buffer is unloaded or has been modified
        if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
          return
        end

        if res then
          local client = vim.lsp.get_client_by_id(ctx.client_id)
          vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
          vim.api.nvim_buf_call(bufnr, function()
            vim.cmd("silent noautocmd update")
          end)
        end
      end
    )
  end

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
      extra_args = {
        "--config",
        vim.fn.expand("~/.node-style-rules/.prettierrc.json"),
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

    -- Spell check
    b.diagnostics.codespell,

    -- Vale
    b.diagnostics.vale.with({
      extra_args = {
        "--config",
        vim.fn.expand("~/.config/vale/vale.ini")
      }
    }),

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
      -- TODO allow auto formatting once prettierd rules are set
      -- if client.supports_method("textDocument/formatting") then
      -- 	vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      -- 	vim.api.nvim_create_autocmd("BufWritePre", {
      -- 		group = augroup,
      -- 		buffer = bufnr,
      -- 		callback = function()
      -- 			-- vim.lsp.buf.format({ bufnr = bufnr })
      -- 			async_formatting(bufnr)
      -- 		end,
      -- 	})
      -- end
    end,
  }))
end

return M
