local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath 'data' .. '/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print 'Installing packer close and reopen Neovim...'
  vim.cmd [[packadd packer.nvim]]
end

-- autocommand that will reload neovim whenever you save plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'single' }
    end,
    prompt_border = 'single',
  },
  git = {
    clone_timeout = 6000, -- seconds
  },
  max_jobs = 20,
  compile_on_sync = true,
}

return packer.startup(function(use)
  -- Packer plugin --
  use {
    'lewis6991/impatient.nvim',
    setup = function()
      require('mrgeek.plugins.impatient')
    end
  }

  use {
    'wbthomason/packer.nvim', -- have packer manage itself
    event = 'VimEnter',
  }

  -- Dependencies --
  use 'nvim-lua/popup.nvim' -- implementation of popup api from vim in neovim
  use 'nvim-lua/plenary.nvim' -- useful lua functions that is used by lots of plugins


  -- UI stuff --
  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true
    },
    config = function()
      require('mrgeek.plugins.lualine')
    end,
  }

  use {
    'stevearc/dressing.nvim',
    requires = {
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('mrgeek.plugins.dressing')
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('mrgeek.treesitter').setup()
    end,
    setup = function()
      require('mrgeek.post_setup').setup_fold()
    end
  }

  use {
    'nvim-treesitter/playground',
    after = 'nvim-treesitter',
  }

  use {
    'windwp/nvim-ts-autotag',
    after = 'nvim-treesitter',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  }

  use {
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    after = {
      'nvim-treesitter'
    }
  }

  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = {
      'nvim-treesitter'
    }
  }

  use {
    'RRethy/nvim-treesitter-textsubjects',
    after = {
      'nvim-treesitter'
    }
  }

  use {
    'p00f/nvim-ts-rainbow',
    after = 'nvim-treesitter',
  }

  use {
    'windwp/nvim-autopairs',
    after = 'nvim-treesitter',
    config = function()
      require('mrgeek.plugins.autopairs')
    end,
  }

  use {
    'kyazdani42/nvim-web-devicons',
    after = 'nvim-treesitter',
  }

  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    branch = 'main',
    config = function()
      require('mrgeek.plugins.bufferline')
    end,
  }

  use {
    'JoosepAlviste/nvim-ts-context-commentstring',
    after = 'nvim-treesitter',
  }

  use {
    'numToStr/Comment.nvim',
    after = 'nvim-ts-context-commentstring',
    config = function()
      require('mrgeek.plugins.comment')
    end,
  }

  use {
    'folke/which-key.nvim',
    event = 'BufRead',
    config = function()
      require('mrgeek.plugins.whichkey')
    end
  }

  use {
    'romgrk/nvim-treesitter-context',
    after = 'nvim-treesitter',
    config = function()
      require('mrgeek.plugins.context')
    end,
  }

  use {
    'glepnir/dashboard-nvim',
    config = function()
      require('mrgeek.plugins.dashboard')
    end,
  }

  use {
    'max397574/better-escape.nvim',
    event = 'InsertEnter',
    config = function()
      require('better_escape').setup {
        mapping = { 'jk' },
        timeout = 300,
      }
    end,
  }

  use {
    'norcalli/nvim-colorizer.lua',
    opt = true,
    event = 'BufRead',
    config = function()
      require 'colorizer'.setup()
    end
  }

  use {
    'ur4ltz/surround.nvim',
    event = 'InsertEnter',
    config = function()
      require('mrgeek.plugins.surround')
    end
  }

  use {
    'folke/twilight.nvim',
    event = 'BufRead',
    config = function()
      require('mrgeek.plugins.twilight')
    end,
  }

  use {
    'Pocco81/TrueZen.nvim',
    event = 'BufRead',
    config = function()
      require('mrgeek.plugins.truezen')
    end,
  }

  use({
    'gbprod/cutlass.nvim',
    config = function()
      require('cutlass').setup({
      })
    end
  })

  use {
    'rcarriga/nvim-notify',
    config = function()
      require('mrgeek.plugins.notify')
    end,
  }

  use {
    'simrat39/symbols-outline.nvim',
    cmd = 'SymbolsOutline',
    config = function()
      require('mrgeek.plugins.symbols_outline')
    end,
  }

  use {
    'akinsho/toggleterm.nvim',
    config = function()
      require('mrgeek.plugins.toggle_term')
    end,
  }

  use {
    'anuvyklack/pretty-fold.nvim',
    requires = {
      {
        'anuvyklack/nvim-keymap-amend'
      },
    },
    config = function()
      require('mrgeek.plugins.pretty_fold')
    end
  }

  -- use {
  --   'filipdutescu/renamer.nvim',
  --   event = 'BufRead',
  --   branch = 'master',
  --   requires = {
  --     {
  --       'nvim-lua/plenary.nvim'
  --     },
  --   },
  --   config = function()
  --     require('mrgeek.plugins.renamer')
  --   end,
  -- }

  use {
    'booperlv/nvim-gomove',
    event = 'BufRead',
    config = function()
      require('gomove').setup {
        -- whether or not to map default key bindings, (true/false)
        map_defaults = true,
        -- whether or not to reindent lines moved vertically (true/false)
        reindent = true,
        -- whether or not to undojoin same direction moves (true/false)
        undojoin = true,
        -- whether to not to move past end column when moving blocks horizontally, (true/false)
        move_past_end_col = false,
      }
    end,
  }

  use {
    'David-Kunz/jester',
    event = 'BufRead',
    config = function()
      require('mrgeek.plugins.jester')
    end,
  }

  use {
    'hoschi/yode-nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
    event = 'BufRead',
    config = function()
      require('yode-nvim').setup({})
    end,
  }

  -- Git --
  use {
    'lewis6991/gitsigns.nvim',
    opt = true,
    config = function()
      require('mrgeek.plugins.gitsigns')
    end,
    setup = function()
      require('mrgeek.utils').packer_lazy_load 'gitsigns.nvim'
    end,
  }

  use {
    'tpope/vim-fugitive',
    opt = true,
    config = function()
    end,
    setup = function()
      require('mrgeek.utils').packer_lazy_load 'vim-fugitive'
    end,
  }

  use {
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('mrgeek.plugins.diffview')
    end,
  }

  -- Color schemes --
  use 'folke/tokyonight.nvim' -- tokyonight theme yay

  use { 'EdenEast/nightfox.nvim' }

  use {
    'marko-cerovac/material.nvim',
    config = function()
      require('mrgeek.theme.material')
    end,
  }

  use 'shaunsingh/moonlight.nvim'

  use({
    'rose-pine/neovim',
    as = 'rose-pine',
  })

  use {
    'projekt0n/github-nvim-theme',
  }
  use {
    'catppuccin/nvim',
    as = 'catppuccin',
    config = function()
      require('mrgeek.plugins.catppuccin')
    end
  }

  -- File managing plugins --
  use {
    'kyazdani42/nvim-tree.lua', -- the filemaneger basically
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    config = function()
      require('mrgeek.plugins.nvimtree')
    end
  }

  use {
    'karb94/neoscroll.nvim', -- pretty smooth scrolling
    config = function()
      require('neoscroll').setup {

      }
    end,
  }

  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require('mrgeek.telescope').setup()
    end,
  }

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    requires = {
      {
        'nvim-telescope/telescope.nvim'
      }
    },
    run = 'make'
  }

  use {
    'nvim-telescope/telescope-file-browser.nvim',
    requires = {
      {
        'nvim-telescope/telescope.nvim'
      }
    },
  }

  use {
    'airblade/vim-rooter',
    config = function()
      vim.g['rooter_cd_cmd'] = 'lcd'
    end
  }

  use {
    'cljoly/telescope-repo.nvim',
    requires = {
      {
        'airblade/vim-rooter'
      },
      {
        'nvim-lua/plenary.nvim'
      },
      {
        'nvim-telescope/telescope.nvim'
      }
    },
  }

  -- use {
  --   'ThePrimeagen/refactoring.nvim',
  --   requires = {
  --     {
  --       'nvim-lua/plenary.nvim'
  --     },
  --     {
  --       'nvim-treesitter/nvim-treesitter'
  --     },
  --   },
  --   after = 'nvim-treesitter',
  --   config = function()
  --     require('refactoring').setup({})
  --   end,
  -- }

  -- use {
  --   'michaelb/sniprun',
  --   event = 'BufRead',
  --   run = 'bash ./install.sh',
  --   config = function()
  --     require('mrgeek.plugins.snip_run')
  --   end,
  -- }

  -- Debugging
  use {
    'mfussenegger/nvim-dap',
    opt = true,
    event = 'BufWinEnter',
    module = { 'dap' },
    wants = { 'nvim-dap-virtual-text', 'dap-buddy.nvim', 'nvim-dap-ui', 'which-key.nvim' },
    requires = {
      'Pocco81/dap-buddy.nvim',
      'theHamsta/nvim-dap-virtual-text',
      'rcarriga/nvim-dap-ui',
      'nvim-telescope/telescope-dap.nvim',
      { 'leoluz/nvim-dap-go', module = 'dap-go' },
      { 'jbyuki/one-small-step-for-vimkind', module = 'osv' },
    },
    config = function()
      require('mrgeek.plugins.dap')
    end,
  }

  -- Debugger management
  use {
    'Pocco81/dap-buddy.nvim',
    branch = 'dev',
    event = 'BufWinEnter',
    -- event = 'BufRead',
  }

  -- LSP base --
  use {
    'neovim/nvim-lspconfig',
  }

  -- LSP plugins --

  use {
    'williamboman/nvim-lsp-installer',
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    after = 'nvim-lspconfig',
  }

  use {
    'ray-x/lsp_signature.nvim',
    after = 'nvim-lspconfig',
    config = function()
      require('mrgeek.plugins.lsp_signature')
    end,
  }

  use {
    'onsails/lspkind-nvim',
    after = 'nvim-lspconfig',
  }

  use {
    'folke/trouble.nvim',
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require('mrgeek.plugins.trouble')
    end
  }

  -- CMP and snippets plugins --
  use {
    'hrsh7th/cmp-nvim-lsp',
  }

  use {
    'rafamadriz/friendly-snippets',
  }

  use {
    'L3MON4D3/LuaSnip',
  }

  use {
    'hrsh7th/nvim-cmp',
    config = function()
      require('mrgeek.cmp').setup()
    end,
  }

  use {
    'saadparwaiz1/cmp_luasnip',
  }

  use {
    'hrsh7th/cmp-nvim-lua',
  }

  use {
    'hrsh7th/cmp-buffer',
  }

  use {
    'hrsh7th/cmp-path',
  }

  use {
    'hrsh7th/cmp-cmdline',
  }

  use {
    'github/copilot.vim'
  }

  -- use {
  --   'tzachar/cmp-tabnine',
  --   run = './install.sh',
  --   requires = 'hrsh7th/nvim-cmp',
  -- }

  use {
    'zbirenbaum/copilot.lua',
    after = { 'copilot.vim' },
    event = { 'VimEnter' },
    -- branch = 'dev',
    config = function()
      vim.defer_fn(function()
        require('copilot').setup()
      end, 100)
    end,
  }

  use {
    'zbirenbaum/copilot-cmp',
    after = { 'copilot.lua', 'nvim-cmp' },
  }

  -- Core
  use { 'Tastyep/structlog.nvim' }

  -- Experimental plugins --
  use {
    'nathom/filetype.nvim', -- better and more extensive filetypes list
    config = function()
      require('filetype').setup({
        overrides = {
          complex = {
            -- Set the filetype of any full filename matching the regex to gitconfig
            ["Dockerfile*"] = "dockerfile", -- Included in the plugin
          },
        },
      })
    end,
  }

  use {
    'phaazon/hop.nvim',
    branch = 'v1',
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end,
  }

  use {
    'dstein64/vim-startuptime',
  }

  use { 'antoinemadec/FixCursorHold.nvim' }

  -- Packer stuff --
  -- automatically set up configuration after cloning packer
  -- this must be at the end of all plugins
  if PACKER_BOOTSTRAP then
    require 'packer'.sync()
  end
end)
