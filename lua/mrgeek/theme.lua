local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. MrGeek.theme.name)

if not status_ok then
  vim.notify('Theme ' .. MrGeek.theme.name .. ' was not found and it was not applied!')
  return
end
