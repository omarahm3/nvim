local fn = vim.fn

-- automatically install packer if its not there
local present, packer = pcall(require, 'mrgeek.packerinit')

if not present then
  vim.notify('Packer was not loaded, probably this is your first time huh?')
  return
end

-- autocommand that will reload neovim whenever you save plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

return packer.startup(function(use)
  -- Packer plugin --
  use {
    'wbthomason/packer.nvim', -- have packer manage itself
    event = 'VimEnter',
  }

  -- Dependencies --
  use 'nvim-lua/popup.nvim' -- implementation of popup api from vim in neovim
  use 'nvim-lua/plenary.nvim' -- useful lua functions that is used by lots of plugins

  -- Color schemes --
  use 'folke/tokyonight.nvim' -- tokyonight theme yay

  -- File managing plugins --
  use {
    'kyazdani42/nvim-tree.lua', -- the filemaneger basically
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    config = function() require'nvim-tree'.setup {

    } end
  }

  use {
    'karb94/neoscroll.nvim', -- pretty smooth scrolling
    config = function()
      require('neoscroll').setup {

      }
    end,
  }

  -- CMP and snippets plugins --
  use {
    'rafamadriz/friendly-snippets',
    event = 'InsertEnter',
  }

  use {
    'L3MON4D3/LuaSnip',
    after = 'friendly-snippets',
  }

  use {
    'hrsh7th/nvim-cmp',
    after = 'LuaSnip',
    config = function()
      require('mrgeek.cmp').setup()
    end,
  }

  use {
    'saadparwaiz1/cmp_luasnip',
    after = 'nvim-cmp',
  }

  use {
    'hrsh7th/cmp-nvim-lua',
    after = 'cmp_luasnip',
  }

  -- use {
  --   'hrsh7th/cmp-nvim-lsp',
  --   after = 'cmp-nvim-lua',
  -- }

  use {
    'hrsh7th/cmp-buffer',
    after = 'cmp-nvim-lua',
  }

  use {
    'hrsh7th/cmp-path',
    after = 'cmp-buffer',
  }

  use {
    'hrsh7th/cmp-cmdline',
    after = 'cmp-path',
  }

  -- Experimental plugins --
  use 'nathom/filetype.nvim' -- better and more extensive filetypes list

  -- Packer stuff --
  -- automatically set up configuration after cloning packer
  -- this must be at the end of all plugins
  if PACKER_BOOTSTRAP then
    require 'packer'.sync()
  end
end)
