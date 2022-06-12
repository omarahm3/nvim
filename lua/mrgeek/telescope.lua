local present, telescope = pcall(require, 'telescope')

if not present then
  return
end

local telescope_actions = require('telescope.actions.set')

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
  end
}

local default = {
  defaults = {
    prompt_prefix = ' ',
    selection_caret = ' ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'descending',
    layout_strategy = 'horizontal',
    layout_config = {
      width = 0.75,
      -- height = 0.80,
      preview_cutoff = 120,
      horizontal = {
        prompt_position = 'bottom',
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
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
      '--glob=!.git/',
    },
    -- file_sorter = require('telescope.sorters').get_fuzzy_file,
    file_ignore_patterns = { 'node_modules' },
    -- generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
    path_display = { shorten = 5 },
    winblend = 0,
    border = {},
    borderchars = {
      '─',
      '│',
      '─',
      '│',
      '╭',
      '╮',
      '╯',
      '╰',
    },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    -- file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    -- grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    -- qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    -- buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
  },
  extensions = {
    file_browser = {
      theme = 'ivy',
      hijack_netrw = true,
      mappings = {
        ['i'] = {},
        ['n'] = {},
      }
    },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    }
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    live_grep = {
      only_sort_text = true,
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

  local extensions = { 'file_browser', 'fzf', 'repo' }

  pcall(function()
    for _, ext in ipairs(extensions) do
      telescope.load_extension(ext)
    end
  end)
end

return M
