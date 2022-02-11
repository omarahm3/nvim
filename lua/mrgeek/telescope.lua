local present, telescope = pcall(require, 'telescope')

if not present then
   return
end

local telescope_actions = require('telescope.actions.set')

-- Fixing issue with folds not working on files opened with telescope
-- REF: https://github.com/nvim-telescope/telescope.nvim/issues/699
local fix_folds = {
  hidden = true,
  attach_mappings = function (_)
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
      vimgrep_arguments = {
         'rg',
         '--color=never',
         '--no-heading',
         '--with-filename',
         '--line-number',
         '--column',
         '--smart-case',
      },
      prompt_prefix = ' ',
      selection_caret = ' ',
      entry_prefix = '  ',
      initial_mode = 'insert',
      selection_strategy = 'reset',
      sorting_strategy = 'ascending',
      layout_strategy = 'horizontal',
      layout_config = {
         horizontal = {
            prompt_position = 'bottom',
            preview_width = 0.55,
            results_width = 0.8,
         },
         vertical = {
            mirror = false,
         },
         width = 0.87,
         height = 0.80,
         preview_cutoff = 120,
      },
      file_sorter = require('telescope.sorters').get_fuzzy_file,
      file_ignore_patterns = { 'node_modules' },
      generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
      path_display = { 'smart' },
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
      file_previewer = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
   },
    extensions = {
      file_browser = {
        theme = 'ivy',
        mappings = {
          ['i'] = {},
          ['n'] = {},
        }
      },
      fzf = {
        fuzzy = true,
        override_generic_sorter = false,
        override_file_sorter = true,
        case_mode = 'smart_case',
      }
    },
    pickers = {
      buffers = fix_folds,
      find_files = fix_folds,
      git_files = fix_folds,
      grep_string = fix_folds,
      live_grep = fix_folds,
      oldfiles = fix_folds,
    },
}

local M = {}

M.setup = function()
   telescope.setup(default)

   local extensions = { 'terms', 'file_browser', 'fzf' }

   pcall(function()
      for _, ext in ipairs(extensions) do
         telescope.load_extension(ext)
      end
   end)
end

return M
