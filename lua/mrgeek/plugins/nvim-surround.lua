local present, plugin = pcall(require, "nvim-surround")

if not present then
  return
end

local utils = require("nvim-surround.utils")

local default = {
  keymaps = { -- vim-surround style keymaps
    insert = "ys",
    insert_line = "yss",
    visual = "S",
    delete = "ds",
    change = "cx",
  },
  delimiters = {
    pairs = {
      ["("] = { "( ", " )" },
      [")"] = { "(", ")" },
      ["{"] = { "{ ", " }" },
      ["}"] = { "{", "}" },
      ["<"] = { "< ", " >" },
      [">"] = { "<", ">" },
      ["["] = { "[ ", " ]" },
      ["]"] = { "[", "]" },
      -- Define pairs based on function evaluations!
      ["i"] = function()
        return {
          utils.get_input("Enter the left delimiter: "),
          utils.get_input("Enter the right delimiter: "),
        }
      end,
      ["f"] = function()
        return {
          utils.get_input("Enter the function name: ") .. "(",
          ")",
        }
      end,
    },
    separators = {
      ["'"] = { "'", "'" },
      ['"'] = { '"', '"' },
      ["`"] = { "`", "`" },
    },
    HTML = {
      ["t"] = "type", -- Change just the tag type
      ["T"] = "whole", -- Change the whole tag contents
    },
    aliases = {
      ["a"] = ">", -- Single character aliases apply everywhere
      ["b"] = ")",
      ["B"] = "}",
      ["r"] = "]",
      -- Table aliases only apply for changes/deletions
      ["q"] = { '"', "'", "`" }, -- Any quote character
      ["s"] = { ")", "]", "}", ">", "'", '"', "`" }, -- Any surrounding delimiter
    },
  },
  highlight_motion = { -- Highlight before inserting/changing surrounds
    duration = 0,
  },
}

plugin.setup(default)
