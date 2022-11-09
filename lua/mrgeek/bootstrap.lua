local M = {}

function M:init()
  -- Enable impatient
  require("impatient")

  -- Setup config
  require('mrgeek.core')

  -- Load theme
  require("mrgeek.theme")

  -- Load commands
  require("mrgeek.commands")

  -- Load auto commands
  require("mrgeek.autocommands")

  -- Load LSP config
  require("mrgeek.lsp").setup()
end

return M
