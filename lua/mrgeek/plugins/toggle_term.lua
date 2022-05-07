local present, toggleterm = pcall(require, 'toggleterm')

if not present then
  return
end

local default = {
  size = 20,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = 'float',
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = 'curved',
		winblend = 0,
		highlights = {
			border = 'Normal',
			background = 'Normal',
		},
	},
}

function _G.set_terminal_keymaps()
  local term_opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, 't', '<ESC>', [[<C-\><C-n>]], term_opts)
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], term_opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], term_opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], term_opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], term_opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], term_opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = require('toggleterm.terminal').Terminal

local lazygit = Terminal:new({ cmd = 'lazygit', hidden = true })

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

local node = Terminal:new({ cmd = 'node', hidden = true })

function _NODE_TOGGLE()
  node:toggle()
end

local htop = Terminal:new({ cmd = 'htop', hidden = true })

function _HTOP_TOGGLE()
  htop:toggle()
end

local gore = Terminal:new({ cmd = 'gore', hidden = true })

function _GORE_TOGGLE()
  gore:toggle()
end

toggleterm.setup(default)
