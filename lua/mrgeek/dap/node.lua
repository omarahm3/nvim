local M = {}

function M.setup()
  local dap_buddy = require("dap-install")
  dap_buddy.config("jsnode", {})
end

return M
