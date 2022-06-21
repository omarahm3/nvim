local present, telescope = pcall(require, "telescope")

if not present then
  return
end

local telescope_actions = require("telescope.actions.set")
local previewers = require("telescope.previewers")
local fb_actions = require("telescope").extensions.file_browser.actions
local layout_actions = require("telescope.actions.layout")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local telescope_custom_actions = {}

function telescope_custom_actions._multiopen(prompt_bufnr, open_cmd)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local num_selections = #picker:get_multi_selection()
  if not num_selections or num_selections <= 1 then
    actions.add_selection(prompt_bufnr)
  end
  actions.send_selected_to_qflist(prompt_bufnr)
  vim.cmd("cfdo " .. open_cmd)
end

function telescope_custom_actions.multi_selection_open(prompt_bufnr)
  telescope_custom_actions._multiopen(prompt_bufnr, "edit")
end

-- Fixing issue with folds not working on files opened with telescope
-- REF: https://github.com/nvim-telescope/telescope.nvim/issues/699
local fix_folds = {
  hidden = true,
  attach_mappings = function(_)
    telescope_actions.select:enhance({
      post = function()
        vim.cmd(":normal! zx")
      end,
    })
    return true
  end,
}

local default = {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.75,
      -- height = 0.80,
      preview_cutoff = 120,
      horizontal = {
        prompt_position = "bottom",
        preview_width = function(_, cols, _)
          if cols < 120 then
            return math.floor(cols * 0.5)
          end
          return math.floor(cols * 0.6)
        end,
        -- results_width = 0.8,
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob=!.git/",
    },
    -- file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = {
      "node_modules/",
      ".git/",
      "yarn.lock",
      "package-lock.json",
    },
    -- generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
    path_display = { "smart", "absolute", "truncate" },
    winblend = 0,
    border = {},
    borderchars = {
      "─",
      "│",
      "─",
      "│",
      "╭",
      "╮",
      "╯",
      "╰",
    },
    color_devicons = true,
    use_less = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
    buffer_previewer_maker = previewers.buffer_previewer_maker,
    mappings = {
      ["i"] = {
        ["<a-j>"] = actions.move_selection_next,
        ["<a-k>"] = actions.move_selection_previous,
        ["<a-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<a-s>"] = actions.select_horizontal,
        ["<cr>"] = actions.select_default,
        ["<a-e>"] = layout_actions.toggle_preview,
        ["<a-l>"] = layout_actions.cycle_layout_next,
        ["<a-b>"] = telescope_custom_actions.multi_selection_open,
      },
      ["n"] = {
        ["<a-j>"] = actions.move_selection_next,
        ["<a-k>"] = actions.move_selection_previous,
        ["<a-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<a-b>"] = telescope_custom_actions.multi_selection_open,
      },
    },
  },
  extensions = {
    file_browser = {
      -- theme = "ivy",
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          ["<a-n>"] = fb_actions.create,
        },
        ["n"] = {},
      },
    },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
  pickers = {
    find_files = {
      find_command = { "fd", "--type=file", "--hidden" },
      hidden = true,
    },
    live_grep = {
      only_sort_text = true,
      file_ignore_patterns = {
        "node_modules/",
        ".git/",
        "yarn.lock",
        "package-lock.json",
      },
    },
    buffers = fix_folds,
    -- find_files = fix_folds,
    git_files = fix_folds,
    grep_string = fix_folds,
    -- live_grep = fix_folds,
    oldfiles = fix_folds,
  },
}

local M = {}

M.setup = function()
  telescope.setup(default)

  local extensions = { "file_browser", "fzf", "repo" }

  pcall(function()
    for _, ext in ipairs(extensions) do
      telescope.load_extension(ext)
    end
  end)
end

return M
