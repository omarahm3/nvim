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
keymap('v', '<A-j>', ':m .+1<CR>==', opts)
keymap('v', '<A-k>', ':m .-2<CR>==', opts)
-- this will keep what you're pasting in the clipboard register
keymap('v', 'p', '"_dP', opts)

-- Visual block --
-- move text up and down
keymap('x', 'J', ':move \'>+1<CR>gv-gv', opts)
keymap('x', 'K', ':move \'<-2<CR>gv-gv', opts)
keymap('x', '<A-j>', ':move \'>+1<CR>gv-gv', opts)
keymap('x', '<A-k>', ':move \'<-2<CR>gv-gv', opts)

-- Terminal --
-- better terminal navigation
keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', term_opts)
keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', term_opts)
keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)

local M = {}

M.telescope = function()
  keymap('n', '<C-p>', ':Telescope find_files <CR>', opts)
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
end

M.buffer_line = function()
  keymap('n', '<S-l>', ':bnext<CR>', opts)
  keymap('n', '<S-h>', ':bprevious<CR>', opts)
  keymap('n', '<leader>x', ':lua require(\'mrgeek.utils\').close_buffer()<CR>', opts)

  keymap('n', '<Tab>', ':BufferLineCycleNext<CR>', opts)
  keymap('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', opts)
end

M.comment = function()
  keymap('n', '<leader>/', ':lua require\'Comment.api\'.toggle_current_linewise()<CR>', opts)
  keymap('v', '<leader>/', ':lua require\'Comment.api\'.toggle_current_linewise_op(vim.fn.visualmode())<CR>', opts)
end

return M
