local M = {}

function M.enable_format_on_save()
  local group = vim.api.nvim_create_augroup("format_on_save", { clear = false })
  vim.api.nvim_create_autocmd("BufWritePre", { callback = function()
    vim.lsp.buf.format()
  end,
  group = group })
  require('notify')("Enabled format on save", "info", { title = "LSP", timeout = 2000 })
end

function M.disable_format_on_save()
  vim.api.nvim_del_augroup_by_name("format_on_save")
  require('notify')("Disabled format on save", "info", { title = "LSP", timeout = 2000 })
end

function M.toggle_format_on_save()
  if vim.fn.exists "#format_on_save#BufWritePre" == 0 then
    M.enable_format_on_save()
  else
    M.disable_format_on_save()
  end
end

vim.api.nvim_create_user_command('LspToggleAutoFormat', 'lua require("lsp.functions").toggle_format_on_save()', {})

-- Custom textDocument/hover LSP handler to colorize colors inside hover results - WIP
function M.custom_hover_handler(_, result)
  local handler = function(_, result)
    if result then
      local lines = vim.split(result.contents.value, '\n')
      local bufnr = vim.lsp.util.open_floating_preview(lines, 'markdown', { border = 'rounded' })
      require('colorizer').highlight_buffer(bufnr, nil, vim.list_slice(lines, 2, #lines), 0, require('colorizer').get_buffer_options(0))
    end
  end

  return handler
end

-- this will highlight the current word under cursor
function M.lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

function M.setup_document_highlight(client, bufnr)
  local status_ok, highlight_supported = pcall(function()
    return client.supports_method "textDocument/documentHighlight"
  end)

  if not status_ok or not highlight_supported then
    return
  end

  local augroup_exist, _ = pcall(vim.api.nvim_get_autocmds, {
    group = "lsp_document_highlight",
  })

  if not augroup_exist then
    vim.api.nvim_create_augroup("lsp_document_highlight", {})
  end

  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    group = "lsp_document_highlight",
    buffer = bufnr,
    callback = vim.lsp.buf.document_highlight,
  })

  vim.api.nvim_create_autocmd("CursorMoved", {
    group = "lsp_document_highlight",
    buffer = bufnr,
    callback = vim.lsp.buf.clear_references,
  })
end

function M.setup_codelens_refresh(client, bufnr)
  local status_ok, codelens_supported = pcall(function()
    return client.supports_method "textDocument/codeLens"
  end)

  if not status_ok or not codelens_supported then
    return
  end

  local augroup_exist, _ = pcall(vim.api.nvim_get_autocmds, {
    group = "lsp_code_lens_refresh",
  })

  if not augroup_exist then
    vim.api.nvim_create_augroup("lsp_code_lens_refresh", {})
  end

  vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
    group = "lsp_code_lens_refresh",
    buffer = bufnr,
    callback = vim.lsp.codelens.refresh,
  })
end

return M
