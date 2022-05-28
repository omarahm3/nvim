local present, surround = pcall(require, 'surround')

if not present then
  return
end

local default = {
  context_offset = 100,
  load_autogroups = false,
  mappings_style = "sandwich",
  map_insert_mode = true,
  quotes = {"'", '"'},
  brackets = {"(", '{', '['},
  space_on_closing_char = false,
  pairs = {
    nestable = {
      b = { "(", ")" },
      s = { "[", "]" },
      B = { "{", "}" },
      a = { "<", ">" }
      },
    linear = {
      q = { "'", "'" },
      t = { "`", "`" },
      d = { '"', '"' }
    },
  },
  prefix = "<C-'>",
}

surround.setup(default)
