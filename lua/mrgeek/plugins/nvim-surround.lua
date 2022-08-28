local present, plugin = pcall(require, "nvim-surround")

if not present then
  return
end

local default = {
  keymaps = { -- vim-surround style keymaps
    -- insert = "ys",
    -- insert_line = "yss",
    visual = "S",
    delete = "ds",
    change = "cx",
  },
  highlight = { -- Highlight before inserting/changing surrounds
    duration = 0,
  },
}

plugin.setup(default)
