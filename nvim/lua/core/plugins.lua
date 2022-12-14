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
    config = function() require('config.theme.tokyonight') end, }
  use { 'catppuccin/nvim',
    config = function() require('config.theme.catppuccin') end, }
  use { 'marko-cerovac/material.nvim',
    config = function() require('config.theme.material') end, }

  -- NOTE: UI stuff
  use { 'kyazdani42/nvim-web-devicons',
  } -- character icons
  use { "rcarriga/nvim-notify",
    -- config = function () require('config.ui.nvim-notify') end,
  }
  use { "folke/noice.nvim",
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function() require('config.ui.noice') end,
  } -- intergrate Notify/CmdLine/UI
  use { 'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require('config.ui.lualine') end,
  } -- statusline
  -- use { 'romgrk/barbar.nvim',
  --   requires = { 'kyazdani42/nvim-web-devicons' },
  --   config = function() require('config.ui.barbar') end,
  -- } -- tabline
  use {'akinsho/bufferline.nvim',
    tag = "v3.*",
    requires = 'nvim-tree/nvim-web-devicons',
    config = function() require("config.ui.bufferline") end,
  } -- tabline
  use { "utilyre/barbecue.nvim",
    requires = {
      "kyazdani42/nvim-web-devicons", -- optional
      "neovim/nvim-lspconfig",
      "smiteshp/nvim-navic",
    },
    commit = '894bd7a',
    config = function() require("config.ui.barbecue") end,
  } -- breadcrumbs

  -- NOTE: Appearence
  use { 'lukas-reineke/indent-blankline.nvim',
    config = function() require('config.appearence.indent-blankline') end,
  } -- indent line
  use { 'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    opt = true,
    event = 'BufWinEnter',
    config = function() require('config.appearence.gitsigns') end,
  } -- git column signs
  use { 'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function() require('config.appearence.todo-comments') end,
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
    config = function() require('config.appearence.treesitter') end,
  }
  -- use { "Jxstxs/conceal.nvim",
  --   requires = "nvim-treesitter/nvim-treesitter"
  -- } -- conceal test to icon

  -- NOTE: LSP stuff
  use { "williamboman/mason.nvim",
    config = function() require('mason').setup() end,
  } -- LSP server collection installer
  use { 'neovim/nvim-lspconfig',
    requires = { 'b0o/schemastore.nvim' },
  } -- LSP server configuration
  use { 'jose-elias-alvarez/null-ls.nvim',
    config = function() require('config.null-ls') end,
    after = 'nvim-lspconfig',
  } -- bridge non-LSP sources to LSP client PERF: currently no use
  use { 'mfussenegger/nvim-jdtls' }


  -- NOTE: Completion stuff
  use { 'L3MON4D3/LuaSnip',
    config = function() require('config.luasnip') end,
    requires = { 'rafamadriz/friendly-snippets', },
  }
  use { 'hrsh7th/nvim-cmp',
    config = function() require('config.completion.nvim-cmp') end,
    requires = {
      { 'L3MON4D3/LuaSnip' },
      { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
    },
    event = 'InsertEnter',
  } -- autocompletion

  -- NOTE: Debugger
  use { 'mfussenegger/nvim-dap'
  } -- dap client
  use { "rcarriga/nvim-dap-ui",
    requires = {"mfussenegger/nvim-dap"},
  } -- dap ui


  -- NOTE: Sidebar
  use { 'kyazdani42/nvim-tree.lua',
    config = function() require('config.sidebar.nvim-tree') end,
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
  use { 'simrat39/symbols-outline.nvim',
    -- config = function () require('symbols-outline').setup() end,
    config = function () require('config.sidebar.symbols-outline') end,
  }
  use { 'windwp/nvim-spectre',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('config.sidebar.nvim-spectre') end,
  } -- replacer

  -- NOTE: Tool stuff
  use { 'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', },
    },
    config = function() require('config.tools.telescope') end,
    event = 'BufWinEnter',
  } -- fuzzy finder
  use { 'voldikss/vim-floaterm',
    opt = true,
    event = 'BufWinEnter',
    config = function() require('config.tools.terminal') end,
  } -- floating terminal
  use { 'is0n/fm-nvim',
    config = function() require('config.tools.fm-nvim') end,
  } -- float tools
  use { "folke/which-key.nvim",
    config = function() require('config.tools.which-key') end
  } -- show keys
  use { 'folke/trouble.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function() require('trouble').setup() end,
  } -- show diagnostic list
  use{ "kylechui/nvim-surround",
    config = function() require("nvim-surround").setup({ }) end,
  }

  -- NOTE: editor stuff
  use { 'kevinhwang91/nvim-ufo',
    requires = 'kevinhwang91/promise-async',
    config = function() require('config.editor.nvim-ufo') end,
  } -- fold block
  use { 'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end,
    event = 'BufWinEnter',
  } -- quick comment
  use { 'rmagatti/auto-session',
    config = function() require('config.editor.auto-session') end,
  } -- restore buffers

  if packer.first_install then packer.sync() end
end)
