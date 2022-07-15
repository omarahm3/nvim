local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- autocommand that will reload neovim whenever you save plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "single" })
    end,
    prompt_border = "single",
  },
  git = {
    clone_timeout = 6000, -- seconds
  },
  max_jobs = 20,
  compile_on_sync = true,
})

return packer.startup(function(use)
  -- Packer plugin --
  use({
    "lewis6991/impatient.nvim",
  })

  use({
    "wbthomason/packer.nvim", -- have packer manage itself
    event = "VimEnter",
  })

  -- Dependencies --
  use("nvim-lua/popup.nvim") -- implementation of popup api from vim in neovim
  use("nvim-lua/plenary.nvim") -- useful lua functions that is used by lots of plugins

  -- UI stuff --
  use({
    "nvim-lualine/lualine.nvim",
    requires = {
      "kyazdani42/nvim-web-devicons",
      opt = true,
    },
    config = [[ require("mrgeek.plugins.lualine") ]],
  })

  use({
    "stevearc/dressing.nvim",
    requires = {
      "MunifTanjim/nui.nvim",
    },
    config = [[ require("mrgeek.plugins.dressing") ]],
  })

  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    requires = {
      "nvim-treesitter/nvim-treesitter-refactor",
      "RRethy/nvim-treesitter-textsubjects",
    },
    config = [[ require("mrgeek.treesitter").setup() ]],
    setup = [[ require("mrgeek.post_setup").setup_fold() ]],
  })

  use({
    "gpanders/nvim-parinfer",
    event = "InsertEnter *",
  })

  use({
    "windwp/nvim-ts-autotag",
    after = "nvim-treesitter",
    config = [[ require("nvim-ts-autotag").setup() ]],
  })

  use({
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    after = {
      "nvim-treesitter",
    },
  })

  use({
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = {
      "nvim-treesitter",
    },
  })

  use({
    "p00f/nvim-ts-rainbow",
    after = "nvim-treesitter",
  })

  use({
    "windwp/nvim-autopairs",
    after = "nvim-treesitter",
    config = [[ require("mrgeek.plugins.autopairs") ]],
  })

  use({
    "kyazdani42/nvim-web-devicons",
    after = "nvim-treesitter",
  })

  use({
    "akinsho/bufferline.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    branch = "main",
    config = [[ require("mrgeek.plugins.bufferline") ]],
  })

  use({
    "JoosepAlviste/nvim-ts-context-commentstring",
    after = "nvim-treesitter",
  })

  use({
    "numToStr/Comment.nvim",
    after = "nvim-ts-context-commentstring",
    config = [[ require("mrgeek.plugins.comment") ]],
  })

  use({
    "folke/which-key.nvim",
    event = "BufRead",
    config = [[ require("mrgeek.plugins.whichkey") ]],
  })

  use({
    "romgrk/nvim-treesitter-context",
    after = "nvim-treesitter",
    config = [[ require("mrgeek.plugins.context") ]],
  })

  use({
    "glepnir/dashboard-nvim",
    config = [[ require("mrgeek.plugins.dashboard") ]],
  })

  use({
    "Shatur/neovim-session-manager",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = [[ require("mrgeek.plugins.session_manager") ]],
  })

  use({
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = [[ require("better_escape").setup({
        mapping = { "jk" },
        timeout = 300,
      }) ]],
  })

  use({
    "norcalli/nvim-colorizer.lua",
    opt = true,
    event = "BufRead",
    config = [[ require("colorizer").setup() ]],
  })

  use({
    "ur4ltz/surround.nvim",
    event = "InsertEnter",
    config = [[ require("mrgeek.plugins.surround") ]],
  })

  use({
    "kylechui/nvim-surround",
    config = [[ require("mrgeek.plugins.nvim-surround") ]],
  })

  use({
    "folke/twilight.nvim",
    event = "BufRead",
    config = [[ require("mrgeek.plugins.twilight") ]],
  })

  use({
    "Pocco81/TrueZen.nvim",
    config = [[ require("mrgeek.plugins.truezen") ]],
  })

  use({
    "gbprod/cutlass.nvim",
    config = [[ require("cutlass").setup({}) ]],
  })

  use({
    "rcarriga/nvim-notify",
    config = [[ require("mrgeek.plugins.notify") ]],
  })

  use({
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    config = [[ require("mrgeek.plugins.symbols_outline") ]],
  })

  use({
    "akinsho/toggleterm.nvim",
    config = [[ require("mrgeek.plugins.toggle_term") ]],
  })

  use({
    "kevinhwang91/nvim-ufo",
    requires = "kevinhwang91/promise-async",
    config = [[ require("ufo").setup() ]],
  })

  use({
    "anuvyklack/pretty-fold.nvim",
    requires = {
      {
        "anuvyklack/nvim-keymap-amend",
      },
    },
    config = [[ require("mrgeek.plugins.pretty_fold") ]],
  })

  use({
    "nvim-neorg/neorg",
    config = [[ require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.norg.dirman"] = {
            config = {
              workspaces = {
                work = "~/notes/work",
                home = "~/notes/home",
              },
            },
          },
        },
      }) ]],
    requires = "nvim-lua/plenary.nvim",
  })

  use({
    "booperlv/nvim-gomove",
    event = "BufRead",
    config = [[ require("gomove").setup({
        -- whether or not to map default key bindings, (true/false)
        map_defaults = true,
        -- whether or not to reindent lines moved vertically (true/false)
        reindent = true,
        -- whether or not to undojoin same direction moves (true/false)
        undojoin = true,
        -- whether to not to move past end column when moving blocks horizontally, (true/false)
        move_past_end_col = false,
      }) ]],
  })

  use({
    "David-Kunz/jester",
    event = "BufRead",
    config = [[ require("mrgeek.plugins.jester") ]],
  })

  use({
    "hoschi/yode-nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    event = "BufRead",
    config = [[ require("yode-nvim").setup({}) ]],
  })

  use({
    "junegunn/vim-easy-align",
    config = [[
      local keymap = vim.keymap.set

      -- Start interactive EasyAlign in visual mode (e.g. vipga)
      keymap("x", "ga", "<Plug>(EasyAlign)")

      -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
      keymap("n", "ga", "<Plug>(EasyAlign)")
    ]],
  })

  -- Git --
  use({
    "lewis6991/gitsigns.nvim",
    opt = true,
    config = [[ require("mrgeek.plugins.gitsigns") ]],
    setup = [[ require("mrgeek.utils").packer_lazy_load("gitsigns.nvim") ]],
  })

  use({
    "tpope/vim-fugitive",
    opt = true,
    setup = [[ require("mrgeek.utils").packer_lazy_load("vim-fugitive") ]],
  })

  use({
    "sindrets/diffview.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = [[ require("mrgeek.plugins.diffview") ]],
  })

  -- Color schemes --
  use("folke/tokyonight.nvim") -- tokyonight theme yay

  use({ "EdenEast/nightfox.nvim" })

  use({
    "marko-cerovac/material.nvim",
    config = [[ require("mrgeek.theme.material") ]],
  })

  use("shaunsingh/moonlight.nvim")

  use({
    "rose-pine/neovim",
    as = "rose-pine",
  })

  use({
    "projekt0n/github-nvim-theme",
  })
  use({
    "catppuccin/nvim",
    as = "catppuccin",
    config = [[ require("mrgeek.plugins.catppuccin") ]],
  })

  -- File managing plugins --
  use({
    "kyazdani42/nvim-tree.lua", -- the filemaneger basically
    requires = {
      "kyazdani42/nvim-web-devicons", -- optional, for file icon
    },
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = [[ require("mrgeek.plugins.nvimtree") ]],
  })

  use({
    "karb94/neoscroll.nvim", -- pretty smooth scrolling
    config = [[ require("neoscroll").setup({}) ]],
  })

  use({
    "nvim-telescope/telescope.nvim",
    config = [[ require("mrgeek.telescope").setup() ]],
  })

  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    requires = {
      {
        "nvim-telescope/telescope.nvim",
      },
    },
    run = "make",
  })

  use({
    "nvim-telescope/telescope-file-browser.nvim",
    requires = {
      {
        "nvim-telescope/telescope.nvim",
      },
    },
  })

  use({
    "nvim-telescope/telescope-frecency.nvim",
    requires = { "tami5/sqlite.lua" },
  })

  use({
    "airblade/vim-rooter",
    config = [[
      vim.g["rooter_cd_cmd"] = "lcd"
    ]],
  })

  use({
    "cljoly/telescope-repo.nvim",
    requires = {
      {
        "airblade/vim-rooter",
      },
      {
        "nvim-lua/plenary.nvim",
      },
      {
        "nvim-telescope/telescope.nvim",
      },
    },
  })

  -- Debugging
  use({
    "mfussenegger/nvim-dap",
    opt = true,
    event = "BufWinEnter",
    module = { "dap" },
    wants = { "nvim-dap-virtual-text", "dap-buddy.nvim", "nvim-dap-ui", "which-key.nvim" },
    requires = {
      "Pocco81/dap-buddy.nvim",
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "nvim-telescope/telescope-dap.nvim",
      { "leoluz/nvim-dap-go", module = "dap-go" },
      { "jbyuki/one-small-step-for-vimkind", module = "osv" },
    },
    config = [[ require("mrgeek.plugins.dap") ]],
  })

  -- Debugger management
  use({
    "Pocco81/dap-buddy.nvim",
    branch = "dev",
    event = "BufWinEnter",
  })

  -- LSP base --
  use({
    "neovim/nvim-lspconfig",
  })

  -- LSP plugins --

  use({
    "williamboman/nvim-lsp-installer",
  })

  use({
    "jose-elias-alvarez/null-ls.nvim",
    -- after = 'nvim-lspconfig',
  })

  use({
    "j-hui/fidget.nvim",
    after = "nvim-lspconfig",
    config = [[ require("fidget").setup({}) ]],
  })

  use({
    "ray-x/lsp_signature.nvim",
    after = "nvim-lspconfig",
    config = [[ require("mrgeek.plugins.lsp_signature") ]],
  })

  use({
    "simrat39/rust-tools.nvim",
  })

  use({
    "onsails/lspkind-nvim",
    after = "nvim-lspconfig",
  })

  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = [[ require("mrgeek.plugins.trouble") ]],
  })

  use({
    "narutoxy/dim.lua",
    requires = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
    config = [[ require("dim").setup({}) ]],
  })

  -- CMP and snippets plugins --
  use({
    "hrsh7th/cmp-nvim-lsp",
  })

  use({
    "rafamadriz/friendly-snippets",
  })

  use({
    "L3MON4D3/LuaSnip",
  })

  use({
    "hrsh7th/nvim-cmp",
    config = [[ require("mrgeek.cmp").setup() ]],
  })

  use({
    "saadparwaiz1/cmp_luasnip",
  })

  use({
    "hrsh7th/cmp-nvim-lua",
  })

  use({
    "hrsh7th/cmp-buffer",
  })

  use({
    "hrsh7th/cmp-path",
  })

  use({
    "hrsh7th/cmp-cmdline",
  })

  -- Core
  use({ "Tastyep/structlog.nvim" })

  -- Experimental plugins --
  use({
    "nathom/filetype.nvim", -- better and more extensive filetypes list
    config = [[
      require("filetype").setup({
        overrides = {
          complex = {
            -- Set the filetype of any full filename matching the regex to gitconfig
            ["Dockerfile*"] = "dockerfile", -- Included in the plugin
          },
        },
      })
    ]],
  })

  use({
    "phaazon/hop.nvim",
    branch = "v1",
    config = [[ require("hop").setup({ keys = "etovxqpdygfblzhckisuran" }) ]],
  })

  use({
    "dstein64/vim-startuptime",
  })

  use({
    "https://gitlab.com/yorickpeterse/nvim-pqf.git",
    config = [[ require("pqf").setup() ]],
  })

  use({ "antoinemadec/FixCursorHold.nvim" })

  use({
    "edluffy/specs.nvim",
    config = [[ require("specs").setup({}) ]],
  })

  -- Packer stuff --
  -- automatically set up configuration after cloning packer
  -- this must be at the end of all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
