local packer = require('core.packer')
local use = packer.use

return packer.startup(function()
  use {
    'wbthomason/packer.nvim',
    'lewis6991/impatient.nvim',
    'nvim-lua/plenary.nvim',
  }

  -- NOTE: colorscheme stuff
  use { 'folke/tokyonight.nvim',
    config = function() require('theme/tokyonight') end, }
  use { 'catppuccin/nvim',
    config = function() require('catppuccin').setup() end, }
  use { 'marko-cerovac/material.nvim',
    config = function() require('theme/material') end, }

  -- NOTE: basic stuff
  use { 'rcarriga/nvim-notify',
    config = function() require('config.notify') end,
  } -- notification
  use { 'kyazdani42/nvim-web-devicons',
  } -- character icons

  -- NOTE: LSP stuff
  use { "williamboman/mason.nvim",
    config = function() require('mason').setup() end,
  } -- LSP server collection installer
  use { 'neovim/nvim-lspconfig',
    requires = { 'b0o/schemastore.nvim' },
  } -- LSP server configuration
  use { 'ray-x/lsp_signature.nvim',
    config = function() require('config.lsp-signature') end,
    after = 'nvim-lspconfig',
  } -- LSP popup function signature
  use { 'folke/trouble.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function() require('trouble').setup() end,
  } -- LSP show diagnostic list
  use { 'jose-elias-alvarez/null-ls.nvim',
    config = function() require('config.null-ls') end,
    after = 'nvim-lspconfig',
  } -- bridge non-LSP sources to LSP client

  -- NOTE: Completion
  use { 'L3MON4D3/LuaSnip',
    config = function() require('config.luasnip') end,
    requires = { 'rafamadriz/friendly-snippets', },
  }
  use { 'hrsh7th/nvim-cmp',
    config = function() require('config.nvim-cmp') end,
    requires = {
      { 'L3MON4D3/LuaSnip' },
      { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      {
        'windwp/nvim-autopairs',
        config = function() require('config.auto-pairs') end,
        after = 'nvim-cmp',
      },
    },
    event = 'InsertEnter',
  } -- autocompletion

  -- NOTE: Debugger
  use { 'mfussenegger/nvim-dap'
  } -- dap client
  use { "rcarriga/nvim-dap-ui",
    requires = {"mfussenegger/nvim-dap"},
  } -- dap ui

  -- NOTE: theme stuff
  use { 'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require('config.lualine') end,
  } -- statusline
  use { 'romgrk/barbar.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function() require('config.barbar') end,
  } -- tabline
  use { "utilyre/barbecue.nvim",
    requires = {
      "neovim/nvim-lspconfig",
      "smiteshp/nvim-navic",
      "kyazdani42/nvim-web-devicons", -- optional
    },
    config = function() require("config.barbecue") end,
    commit = "f13fad8217cabea"
  } -- breadcrumbs
  use { 'lukas-reineke/indent-blankline.nvim',
    config = function() require('config.indent-blankline') end,
  } -- indent line
  use { 'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    opt = true,
    event = 'BufWinEnter',
    config = function() require('config.gitsigns') end,
  } -- git column signs
  use { 'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function() require('config.todo-comments') end,
    event = 'BufWinEnter',
  } -- todo highlights
  use { 'norcalli/nvim-colorizer.lua',
    opt = true,
    cmd = { 'ColorizerToggle' },
    config = function() require('colorizer').setup() end,
    event = 'BufWinEnter',
  } -- colorized hex codes
  use { 'nvim-treesitter/nvim-treesitter',
    requires = {
      'windwp/nvim-ts-autotag',
      'p00f/nvim-ts-rainbow',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-refactor',
    },
    run = ':TSUpdate',
    config = function() require('config.treesitter') end,
  }

  -- NOTE: tools
  use { 'is0n/fm-nvim',
    config = function() require('config.fm-nvim') end,
  } -- float tools
  use { 'kyazdani42/nvim-tree.lua',
    config = function() require('config.nvim-tree') end,
    cmd = {
      'NvimTreeClipboard',
      'NvimTreeClose',
      'NvimTreeFindFile',
      'NvimTreeOpen',
      'NvimTreeRefresh',
      'NvimTreeToggle',
    },
    event = 'VimEnter',
  } -- file explorer
  use { 'windwp/nvim-spectre',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('config.nvim-spectre') end,
  } -- replacer
  use { 'voldikss/vim-floaterm',
    opt = true,
    event = 'BufWinEnter',
    config = function() require('config.terminal') end,
  } -- floating terminal
  use { "folke/which-key.nvim",
    config = function() require('config.which-key') end
  } -- show keys
  use { 'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', },
    },
    config = function() require('config.telescope') end,
    event = 'BufWinEnter',
  } -- fuzzy finder

  use { 'glepnir/dashboard-nvim',
    config = function() require('config.dashboard') end,
  }

  -- NOTE: editor stuff
  use { 'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end,
    event = 'BufWinEnter',
  } -- quick comment
  use { 'kevinhwang91/nvim-ufo',
    requires = 'kevinhwang91/promise-async',
    config = function() require('config/nvim-ufo') end,
  } -- fold block
  use { 'rmagatti/auto-session',
    config = function() require('config.auto-session') end,
  }

  if packer.first_install then packer.sync() end
end)
