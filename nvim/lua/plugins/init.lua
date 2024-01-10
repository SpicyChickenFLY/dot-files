local icons = require('core.icons')

local plugins = {
  'nvim-lua/plenary.nvim',       -- basic algorithms
  'nvim-tree/nvim-web-devicons', -- character icons

  -- NOTE: themes
  {
    'catppuccin/nvim',
    config = function() require('plugins.theme.catppuccin') end,
  }, -- lovely colorscheme

  -- NOTE: UI stuff
  {
    'nvim-lualine/lualine.nvim',
    config = function() require('plugins.ui.lualine') end,
    lazy = false,
  }, -- statusline
  {
    'akinsho/bufferline.nvim',
    version = "*",
    init = function() require('core.mappings').load_mappings "bufferline" end,
    config = function() require("plugins.ui.bufferline") end,
    lazy = false,
  }, -- tabline

  -- NOTE: Appearence
  {
    "utilyre/barbecue.nvim",
    dependencies = {
      "kyazdani42/nvim-web-devicons", -- optional
      "neovim/nvim-lspconfig",
      "smiteshp/nvim-navic",
    },
    event = 'BufWinEnter',
    config = function() require("plugins.ui.barbecue") end,
  }, -- breadcrumbs
  {
    'nmac427/guess-indent.nvim',
    event = 'BufWinEnter',
    config = function() require('guess-indent').setup {} end,
  }, -- guess what indent should be like
  {
    'lukas-reineke/indent-blankline.nvim',
    -- init = function() require("core.utils").lazy_load "ibl" end,
    version = "*",
    main = "ibl",
    event = 'BufWinEnter',
    config = function() require('plugins.appearence.indent-blankline') end,
  }, -- indent line
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'BufWinEnter',
    init = function() require('core.mappings').load_mappings "gitsigns" end,
    config = function() require('plugins.appearence.gitsigns') end,
  }, -- git column signs
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
      {
        "luukvbaal/statuscol.nvim",
        config = function() require('plugins.appearence.statuscol') end,
      }
    },
    event = 'BufWinEnter',
    config = function() require('plugins.appearence.nvim-ufo') end,
  }, -- fold block
  {
    'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function() require('plugins.appearence.todo-comments') end,
    event = 'BufWinEnter',
  }, -- todo highlights
  {
    'NvChad/nvim-colorizer.lua',
    init = function()
      require("core.utils").lazy_load "nvim-colorizer.lua"
    end,
    config = function() require('colorizer').setup({}) end,
  }, -- colorized hex codes
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      -- 'nvim-treesitter/nvim-treesitter-textobjects',
      -- 'theHamsta/crazy-node-movement',
      -- 'windwp/nvim-ts-autotag',
      -- 'HiPhish/nvim-ts-rainbow2',
      -- 'JoosepAlviste/nvim-ts-context-commentstring',
    },
    run = ':TSUpdate',
    event = 'BufWinEnter',
    config = function() require('plugins.appearence.treesitter') end,
  },
  {
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end,
    event = 'BufWinEnter',
  }, -- quick comment

  -- NOTE: Language stuff
  {
    "williamboman/mason.nvim",
    init = function() require('core.mappings').load_mappings "mason" end,
    cmd = {
      "Mason",
      "MasonUpdate",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
    },
    config = function() require('mason').setup() end,
  }, -- LSP server collection installer
  {
    'neovim/nvim-lspconfig',
    init = function()
      require("core.utils").lazy_load "nvim-lspconfig"
      require('core.mappings').load_mappings "lspconfig"
    end,
    dependencies = { 'b0o/schemastore.nvim' },
    config = function() require('plugins.lsp.lspconfig') end,
  },                             -- LSP server configuration
  { 'mfussenegger/nvim-jdtls' }, -- Java LSP
  {
    'mfussenegger/nvim-lint',
    event = "VeryLazy",
    config = function() require('plugins.completion.lint') end,
  }, -- Linter
  {
    'mhartington/formatter.nvim',
    event = "VeryLazy",
    config = function() require('plugins.completion.formatter') end,
  }, -- Formatter

  -- NOTE: Debugger
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      {
        'mfussenegger/nvim-dap',
        init = function() require('core.mappings').load_mappings "dap" end,
        config = function() require('plugins.lsp.nvim-dap') end,
      }, -- dap client
      {
        "theHamsta/nvim-dap-virtual-text",
        config = function() require("nvim-dap-virtual-text").setup({}) end,
      }, -- dap virtual text
    },
  },     -- dap ui


  -- NOTE: Completion stuff
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        dependencies = { 'rafamadriz/friendly-snippets', },
        config = function() require('plugins.completion.luasnip') end,
      },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua',     after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp',     after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer',       after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path',         after = 'nvim-cmp' },
    },
    event = { 'InsertEnter', 'CmdlineEnter' },
    config = function() require('plugins.completion.nvim-cmp') end,
  }, -- autocompletion


  -- NOTE: Sidebar
  {
    'kyazdani42/nvim-tree.lua',
    cmd = {
      'NvimTreeClipboard',
      'NvimTreeClose',
      'NvimTreeFindFile',
      'NvimTreeOpen',
      'NvimTreeRefresh',
      'NvimTreeToggle',
    },
    event = 'VimEnter',
    init = function() require('core.mappings').load_mappings "nvimtree" end,
    config = function() require('plugins.sidebar.nvim-tree') end,
  }, -- file explorer
  {
    'windwp/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    init = function() require('core.mappings').load_mappings "spectre" end,
    config = function() require('plugins.sidebar.nvim-spectre') end,
  }, -- replacer

  -- NOTE: Tool stuff
  {
    "sindrets/diffview.nvim",
    init = function() require('core.mappings').load_mappings "diffview" end,
    cmd = { "DiffviewOpen", "DiffviewToggleFiles", "DiffviewFileHistory" },
    config = function() require("plugins.tools.diffview") end
  }, -- git diffview/mergetool
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build', },
      'xiyaowong/telescope-emoji.nvim',
    },
    init = function() require('core.mappings').load_mappings "telescope" end,
    cmd = "Telescope",
    config = function() require('plugins.tools.telescope') end,
  }, -- fuzzy finder
  {
    "ziontee113/icon-picker.nvim",
    dependencies = { 'stevearc/dressing.nvim' },
    init = function() require('core.mappings').load_mappings "iconpicker" end,
    cmd = "IconPickerNormal",
    config = function() require("icon-picker").setup { disable_legacy_commands = true } end,
  },
  {
    'voldikss/vim-floaterm',
    init = function() require('core.mappings').load_mappings "floaterm" end,
    cmd = { "FloatermNew", "FloatermToggle" },
    config = function() require('plugins.tools.terminal') end,
  }, -- floating terminal
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require('core.mappings').load_mappings "whichkey"
    end,
    config = function() require('plugins.tools.which-key') end
  }, -- show keys
  {
    "kylechui/nvim-surround",
    event = "BufWinEnter",
    config = function() require("nvim-surround").setup({}) end,
  },
  {
    "windwp/nvim-autopairs",
    event = "BufWinEnter",
    config = function() require("nvim-autopairs").setup {} end
  },
  {
    'phaazon/hop.nvim',
    branch = 'v2',
    init = function() require('core.mappings').load_mappings "hop" end,
    config = function() require 'hop'.setup { keys = 'asdfghjkl;qwertyuiopzxcvbnm' } end
  },
  -- {
  --   'rest-nvim/rest.nvim',
  --   event = "VeryLazy",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function() require("plugins.tools.rest") end
  -- }, -- rest client
  {
    "tpope/vim-dadbod",
    init = function() require("core.mappings").load_mappings "dadbod" end,
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnetion", "DBUIFindBuffer" },
    -- event = "VeryLazy",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion"
    },
    config = function() require("plugins.tools.dadbod") end,
  },
  {
    'rmagatti/auto-session',
    init = function() require('core.mappings').load_mappings "autosession" end,
    cmd = {
      "SessionSave",
      "SessionRestore",
      "SessionDelete",
      "SessionPurgeOrphaned",
      "Autosession",
    },
    config = function() require('plugins.tools.auto-session') end,
  } -- restore buffers
}

local config = {
  defaults = { lazy = true },
  install = { colorscheme = { "nvchad" } },

  ui = {
    icons = icons.lazy,
  },

  performance = {
    rtp = {
      disabled_plugins = {
        'netrw', 'netrwPlugin', 'netrwSettings', 'netrwFileHandlers', -- builtin file explorer
        'gzip', 'zip', 'zipPlugin', 'tar', 'tarPlugin',               -- edit compressed files
        'getscript', 'getscriptPlugin',
        'vimball', 'vimballPlugin',                                   -- create and unpack .vba files
        '2html_plugin', 'tohtml',                                     -- convert a file with highlight to html
        'logipat',                                                    -- operators on pattern
        'rrhelper',                                                   -- remote wait editing
        'spellfile_plugin',                                           -- downlload spell file
        'matchit',                                                    -- highlight
        'tutor', 'rplugin', 'syntax', 'synmenu', 'optwin', 'compiler', 'bugreport',
      },
    },
  },
}

require("lazy").setup(plugins, config)
