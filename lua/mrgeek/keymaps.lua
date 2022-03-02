local opts = {
  noremap = true,
  silent = true,
}

local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

-- Remap space as a leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Modes
--    normal_mode = 'n'
--    insert_mode = 'i'
--    visual_mode = 'v'
--    visual_block_mode = 'x'
--    term_mode = 't'
--    command_mode = 'c'

-- Normal --
-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Format code
keymap('n', '<leader>f', ':Format<CR>', opts)

-- press escape to hide search highlights
keymap('n', '<Esc>', ':noh<CR>', opts)

keymap('n', '<leader>e', ':NvimTreeToggle<CR>', opts)
keymap('n', '<C-n>', ':NvimTreeToggle<CR>', opts)

-- resize with arrows
keymap('n', '<C-Up>', ':resize -2<CR>', opts)
keymap('n', '<C-Down>', ':resize +2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Insert --
-- press jk fast enough to go to visual mode
keymap('i', 'jk', '<ESC>', opts)

-- Visual --
-- Stay in indent mode
keymap('v', '<S-Tab>', '<gv', opts)
keymap('v', '<Tab>', '>gv', opts)

-- move text up and down
-- keymap('v', '<A-j>', ':m .+1<CR>==', opts)
-- keymap('v', '<A-k>', ':m .-2<CR>==', opts)
-- this will keep what you're pasting in the clipboard register
keymap('v', 'p', '"_dP', opts)

-- Format code
keymap('v', '<leader>f', ':lua vim.lsp.buf.range_formatting()<CR>', opts)

-- Visual block --
-- move text up and down
-- keymap('x', 'J', ':move ">+1<CR>gv-gv', opts)
-- keymap('x', 'K', ':move "<-2<CR>gv-gv', opts)
-- keymap('x', '<A-j>', ':move ">+1<CR>gv-gv', opts)
-- keymap('x', '<A-k>', ':move "<-2<CR>gv-gv', opts)

-- Terminal --
-- better terminal navigation
keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', term_opts)
keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', term_opts)
keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)

local M = {}

M.telescope = function()
  keymap('n', '<C-p>', ':lua require "telescope.builtin".git_files()<CR>', opts)
  keymap('n', '<leader>ff', ':lua require "telescope".extensions.file_browser.file_browser() <CR>', opts)
  keymap('n', '<leader>fb', ':Telescope buffers <CR>', opts)
  keymap('n', '<leader>fa', ':Telescope find_files follow=true no_ignore=true hidden=true <CR>', opts)
  keymap('n', '<leader>gm', ':Telescope git_commits <CR>', opts)
  keymap('n', '<leader>fw', ':Telescope live_grep <CR>', opts)
  keymap('n', '<leader>fo', ':Telescope oldfiles <CR>', opts)
  keymap('n', '<leader>gt', ':Telescope git_status <CR>', opts)
end

M.vim_fugitive = function()
  keymap('n', '<leader>gs', ':G<CR>', opts)
  keymap('n', '<leader>gb', ':G blame<CR>', opts)
  keymap('n', '<leader>gh', ':0Gclog<CR>', opts)
end

M.git_signs = function()
  keymap('n', ']c', "&diff ? ']c' : ':Gitsigns next_hunk<CR>'", { expr = true })
  keymap('n', '[c', "&diff ? ']c' : ':Gitsigns prev_hunk<CR>'", { expr = true })

  keymap('n', '<leader>hs', ':Gitsigns stage_hunk<CR>', opts)
  keymap('v', '<leader>hs', ':Gitsigns stage_hunk<CR>', opts)
  keymap('n', '<leader>hr', ':Gitsigns reset_hunk<CR>', opts)
  keymap('v', '<leader>hr', ':Gitsigns reset_hunk<CR>', opts)
  keymap('n', '<leader>hS', ':Gitsigns stage_buffer<CR>', opts)
  keymap('n', '<leader>hu', ':Gitsigns undo_stage_hunk<CR>', opts)
  keymap('n', '<leader>hR', ':Gitsigns reset_buffer<CR>', opts)
  keymap('n', '<leader>hp', ':Gitsigns preview_hunk<CR>', opts)
  keymap('n', '<leader>hb', ':lua require"gitsigns".blame_line{full=true}<CR>', opts)
  keymap('n', '<leader>tb', ':Gitsigns toggle_current_line_blame<CR>', opts)
  keymap('n', '<leader>hd', ':Gitsigns diffthis<CR>', opts)
  keymap('n', '<leader>hD', ':lua require"gitsigns".diffthis("~")<CR>', opts)
  keymap('n', '<leader>td', ':Gitsigns toggle_deleted<CR>', opts)
end

M.buffer_line = function()
  keymap('n', '<S-l>', ':bnext<CR>', opts)
  keymap('n', '<S-h>', ':bprevious<CR>', opts)
  keymap('n', '<leader>x', ':lua require("mrgeek.utils").close_buffer()<CR>', opts)

  keymap('n', '<Tab>', ':BufferLineCycleNext<CR>', opts)
  keymap('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', opts)
end

M.comment = function()
  keymap('n', '<leader>/', ':lua require"Comment.api".toggle_current_linewise()<CR>', opts)
  keymap('v', '<leader>/', ':lua require"Comment.api".toggle_current_linewise_op(vim.fn.visualmode())<CR>', opts)
end

M.dashboard = function()
  keymap('n', '<leader>bm', ':DashboardJumpMarks<CR>', opts)
  keymap('n', '<leader>fn', ':DashboardNewFile<CR>', opts)
  keymap('n', '<leader>db', ':Dashboard<CR>', opts)
  keymap('n', '<leader>l', ':SessionLoad<CR>', opts)
  keymap('n', '<leader>ss', ':SessionSave<CR>', opts)
end

M.twilight = function()
  keymap('n', '<leader>tw', ':Twilight<CR>', opts)
end

M.symbols_outline = function()
  keymap('n', '<F8>', ':SymbolsOutline<CR>', opts)
end

M.toggle_term = function()
  keymap('n', '<leader>tf', ':ToggleTerm direction=float<CR>', opts)
  keymap('n', '<leader>th', ':ToggleTerm size=10 direction=horizontal<CR>', opts)
  keymap('n', '<leader>tv', ':ToggleTerm size=80 direction=vertical<CR>', opts)
  keymap('n', '<leader>tn', ':lua _NODE_TOGGLE()<CR>', opts)
  keymap('n', '<leader>tt', ':lua _HTOP_TOGGLE()<CR>', opts)
  keymap('n', '<leader>tg', ':lua _LAZYGIT_TOGGLE()<CR>', opts)
end

M.refactoring = function()
  keymap('v', '<leader>rr', '<Esc>:lua require("telescope").extensions.refactoring.refactors()<CR>', opts)
end

M.sniprun = function()
  keymap('v', '<leader>sr', ':lua require("sniprun").run("v")<CR>', opts)
  keymap('n', '<leader>sr', ':lua require("sniprun").run()<CR>', opts)
end

M.renamer = function()
  keymap('i', '<F2>', ':lua require("renamer").rename()<CR>', opts)
  keymap('n', '<leader>rn', ':lua require("renamer").rename()<CR>', opts)
  keymap('v', '<leader>rn', ':lua require("renamer").rename()<CR>', opts)
end

-- Moving blocks
M.go_move = function()
  keymap("n", "<S-h>", "<Plug>GoNSMLeft", opts)
  keymap("n", "<S-j>", "<Plug>GoNSMDown", opts)
  keymap("n", "<S-k>", "<Plug>GoNSMUp", opts)
  keymap("n", "<S-l>", "<Plug>GoNSMRight", opts)

  -- keymap("x", "<S-h>", "<Plug>GoVSMLeft", opts)
  -- keymap("x", "<S-j>", "<Plug>GoVSMDown", opts)
  -- keymap("x", "<S-k>", "<Plug>GoVSMUp", opts)
  -- keymap("x", "<S-l>", "<Plug>GoVSMRight", opts)

  -- keymap("n", "<C-h>", "<Plug>GoNSDLeft", opts)
  -- keymap("n", "<C-j>", "<Plug>GoNSDDown", opts)
  -- keymap("n", "<C-k>", "<Plug>GoNSDUp", opts)
  -- keymap("n", "<C-l>", "<Plug>GoNSDRight", opts)

  -- keymap("x", "<C-h>", "<Plug>GoVSDLeft", opts)
  -- keymap("x", "<C-j>", "<Plug>GoVSDDown", opts)
  -- keymap("x", "<C-k>", "<Plug>GoVSDUp", opts)
  -- keymap("x", "<C-l>", "<Plug>GoVSDRight", opts)
end

M.jester = function()
  keymap("n", "<leader>jt", ":lua require('jester').run()<CR>", opts)
  keymap("n", "<leader>jf", ":lua require('jester').run_file()<CR>", opts)
  keymap("n", "<leader>jl", ":lua require('jester').run_last()<CR>", opts)
  keymap("n", "<leader>jdd", ":lua require('jester').debug()<CR>", opts)
  keymap("n", "<leader>jdf", ":lua require('jester').debug_file()<CR>", opts)
  keymap("n", "<leader>jdl", ":lua require('jester').debug_last()<CR>", opts)
end

M.yoda = function()
  keymap("v", "<leader>yc", ":YodeCreateSeditorFloating<CR>", opts)
  keymap("v", "<leader>yr", ":YodeCreateSeditorReplace<CR>", opts)
  keymap("n", "<leader>yd", ":YodeBufferDelete<CR>", opts)
end

return M
