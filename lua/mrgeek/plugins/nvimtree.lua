local present, nvim_tree = pcall(require, 'nvim-tree')

if not present then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")

if not config_status_ok then
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

local default = {
  disable_netrw = false,
  hijack_netrw = true,
  open_on_setup = false,
  ignore_ft_on_setup = {
    "startify",
    "dashboard",
    "alpha",
  },
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = false,
  renderer = {
    root_folder_modifier = ':t',
    highlight_git = true,
    icons = {
      show = {
        git = true,
        folder = true,
        folder_arrow = true,
        file = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          deleted = "",
          untracked = "U",
          ignored = "◌",
        },
        folder = {
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
        },
      }
    },
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  actions = {
    open_file = {
      quit_on_open = true,
      resize_window = true,
      window_picker = {
        enable = true,
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      }
    },
  },
  view = {
    width = 30,
    hide_root_folder = false,
    side = "left",
    mappings = {
      custom_only = false,
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
        { key = "h", cb = tree_cb "close_node" },
        { key = "v", cb = tree_cb "vsplit" },
      },
    },
    number = false,
    relativenumber = false,
  },
}

nvim_tree.setup(default)
