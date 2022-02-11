local M = {}

M.setup_fold = function ()
  -- vim.cmd'set foldmethod=expr'
  -- vim.cmd'set foldexpr=nvim_treesitter#foldexpr()'
  -- vim.cmd'set foldcolumn=auto:2'
  -- vim.cmd'set foldlevelstart=0'
  -- vim.cmd'set foldminlines=4'
  -- vim.cmd'set foldopen=block,hor,mark,jump,percent,quickfix,search,tag,undo'
  vim.wo.foldmethod = 'expr'
  vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
  vim.wo.foldenable = false -- Can be enabled directly on buffer using 'zi'
end

return M
