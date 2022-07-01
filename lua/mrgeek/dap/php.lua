local M = {}

function M.setup()
  local dap = require("dap")

  dap.configurations.php = {
    {
      type = "php",
      request = "launch",
      name = "Listen for xdebug",
      port = "9001",
      log = true,
      pathMappings = {
        ["/var/www"] = "${workspaceFolder}",
        ["/var/www/web"] = "${workspaceFolder}/web",
        ["/var/www/app_dev.php"] = "${workspaceFolder}/web/app_dev.php",
        ["/var/www/vendor"] = "${workspaceFolder}/vendor",
      },
    },
  }

  dap.adapters.php = {
    type = "executable",
    command = "node",
    args = { os.getenv("HOME") .. "/.local/share/nvim/dapinstall/php/vscode-php-debug/out/phpDebug.js" },
  }
end

return M
