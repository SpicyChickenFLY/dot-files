local icons = require('core.icons')

local plugins = {
  'nvim-lua/plenary.nvim',       -- basic algorithms
  { 'nvim-tree/nvim-web-devicons', lazy = true }, -- character icons

  -- NOTE: UI stuff
  {
    'catppuccin/nvim',
    lazy = false,
    config = function() require('plugins.ui.catppuccin') end,
  }, -- lovely colorscheme
  {
    'nvim-lualine/lualine.nvim',
    config = function() require('plugins.ui.lualine') end,
    lazy = false,
  }, -- statusline
  {
    'akinsho/bufferline.nvim',
    init = function() require('core.mappings').load "bufferline" end,
    config = function() require("plugins.ui.bufferline") end,
    lazy = false,
  }, -- tabline
  {
    "folke/which-key.nvim",
    init = function() require('core.mappings').load "whichkey" end,
    config = function() require('plugins.tools.which-key') end,
    lazy = false
  }, -- show keys
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    event = "VeryLazy",
    config = function() require('plugins.ui.noice') end,
  }, -- popup uis

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
    main = "ibl",
    event = 'BufWinEnter',
    config = function() require('plugins.appearence.indent-blankline') end,
  }, -- indent line
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'BufWinEnter',
    init = function() require('core.mappings').load "gitsigns" end,
    config = function() require('plugins.appearence.gitsigns') end,
  }, -- git column signs
  {
    "luukvbaal/statuscol.nvim",
    event = 'BufWinEnter',
    config = function() require('plugins.appearence.statuscol') end,
  }, -- status line
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
      "luukvbaal/statuscol.nvim",
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
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    run = ':TSUpdate',
    event = 'BufWinEnter',
    config = function() require('plugins.appearence.treesitter') end,
  }, -- tree sitter
  {
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end,
    event = 'BufWinEnter',
  }, -- quick comment

  -- NOTE: LSP staff
  {
    "williamboman/mason.nvim",
    init = function() require('core.mappings').load "mason" end,
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
      require('core.mappings').load "lspconfig"
    end,
    dependencies = { 'b0o/schemastore.nvim' },
    config = function() require('plugins.lsp.lspconfig') end,
  }, -- LSP server configuration
  { 'mfussenegger/nvim-jdtls' }, -- Java LSP
  {
    'mfussenegger/nvim-lint',
    event = "VeryLazy",
    config = function() require('plugins.lsp.lint') end,
  }, -- Linter
  {
    'mhartington/formatter.nvim',
    init = function() require('core.mappings').load "formatter" end,
    cmd = "FormatWrite",
    config = function() require('plugins.lsp.formatter') end,
  }, -- Formatter
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      {
        'mfussenegger/nvim-dap',
        init = function() require('core.mappings').load "dap" end,
        config = function() require('plugins.lsp.nvim-dap') end,
      }, -- DAP client
      {
        "theHamsta/nvim-dap-virtual-text",
        config = function() require("nvim-dap-virtual-text").setup({}) end,
      }, -- DAP virtual text
    },
  }, -- DAP ui
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        dependencies = { 'rafamadriz/friendly-snippets', },
        config = function() require('plugins.lsp.luasnip') end,
      },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua',     after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp',     after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer',       after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path',         after = 'nvim-cmp' },
      { 'hrsh7th/cmp-cmdline',         after = 'nvim-cmp' },
    },
    event = { 'InsertEnter', 'CmdlineEnter' },
    config = function() require('plugins.lsp.nvim-cmp') end,
  }, -- autocompletion
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-go",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "VeryLazy",
    init = function() require('core.mappings').load "neotest" end,
    config = function() require('plugins.lsp.neotest') end,
  }, -- unit test
  -- NOTE: Sidebar
  {
    "folke/edgy.nvim",
    -- init = function() require('core.mappings').load "edge" end,
    opts = require('plugins.sidebar.edgy'),
    event = "VeryLazy"
  }, -- integrate all sidebar tool in one layout
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
    init = function() require('core.mappings').load "nvimtree" end,
    config = function() require('plugins.sidebar.nvim-tree') end,
  }, -- file explorer
  {
    'windwp/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    init = function() require('core.mappings').load "spectre" end,
    config = function() require('plugins.sidebar.nvim-spectre') end,
  }, -- replacer
  {
    "hedyhli/outline.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    init = function() require('core.mappings').load "outline" end,
    cmd = "Outline",
    config = function() require("plugins.sidebar.outline") end,
  }, -- outline

  -- NOTE: Tool stuff
  {
    "sindrets/diffview.nvim",
    init = function() require('core.mappings').load "diffview" end,
    cmd = { "DiffviewOpen", "DiffviewToggleFiles", "DiffviewFileHistory" },
    config = function() require("plugins.tools.diffview") end
  }, -- git diffview/mergetool
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build', },
      'nvim-telescope/telescope-ui-select.nvim',
    },
    init = function() require('core.mappings').load "telescope" end,
    cmd = "Telescope",
    config = function() require('plugins.tools.telescope') end,
  }, -- fuzzy finder
  {
    "ziontee113/icon-picker.nvim",
    dependencies = { 'stevearc/dressing.nvim' },
    init = function() require('core.mappings').load "iconpicker" end,
    cmd = "IconPickerNormal",
    config = function() require("icon-picker").setup { disable_legacy_commands = true } end,
  }, -- icon picker
  {
    'voldikss/vim-floaterm',
    init = function() require('core.mappings').load "floaterm" end,
    cmd = { "FloatermNew", "FloatermToggle" },
    config = function() require('plugins.tools.floaterm') end,
  }, -- floating terminal
  {
    "kylechui/nvim-surround",
    event = "BufWinEnter",
    config = function() require("nvim-surround").setup({}) end,
  }, -- surround signs
  {
    "windwp/nvim-autopairs",
    event = "BufWinEnter",
    config = function() require("nvim-autopairs").setup {} end
  }, -- auto pair
  {
    'phaazon/hop.nvim',
    branch = 'v2',
    cmd = { "HopWord", "HopPattern" },
    init = function() require('core.mappings').load "hop" end,
    config = function() require 'hop'.setup { keys = 'asdfghjkl;qwertyuiopzxcvbnm' } end
  }, -- hop to anywhere
  {
    'rest-nvim/rest.nvim',
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "",
    config = function() require("plugins.tools.rest") end
  }, -- rest client
  {
    "kristijanhusak/vim-dadbod-ui",
    init = function() require("core.mappings").load "dadbod" end,
    -- event = "VeryLazy",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true},
      {
        "kristijanhusak/vim-dadbod-completion",
        ft = { 'sql', 'mysql', 'plsql'},
        lazy = true
      },
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnetion", "DBUIFindBuffer" },
    config = function() require("plugins.tools.dadbod") end,
  }, -- database client
  {
      "iamcco/markdown-preview.nvim",
      init = function()
        vim.cmd([[
        function OpenMarkdownPreview (url)
          execute "silent ! firefox --new-window --app=" .a:url
        endfunction
        ]])
        vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'
      end,
      cmd = {
        "MarkdownPreviewToggle",
        "MarkdownPreview",
        "MarkdownPreviewStop"
      },
      ft = { "markdown" },
      build = function() vim.fn["mkdp#util#install"]() end,
  }, -- markdown preview
  {
    'rmagatti/auto-session',
    init = function() require('core.mappings').load "autosession" end,
    cmd = {
      "SessionSave",
      "SessionRestore",
      "SessionDelete",
      "SessionPurgeOrphaned",
      "Autosession",
    },
    config = function() require('plugins.tools.auto-session') end,
  }, -- restore buffers
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function() require('core.mappings').load "trouble" end,
    cmd = {
      "Trouble",
      "TroubleClose",
      "TroubleToggle",
      "TroubleRefresh",
    }
  }, -- list all diagnositic && todos
  {
    "ahmedkhalf/project.nvim",
    init = function() require('core.mappings').load "project" end,
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    event = "VeryLazy",
    config = function() require('plugins.tools.project') end,
  }, -- project manager
}

local config = {
  defaults = { lazy = true },
  install = { colorscheme = { "nvchad" } },
  ui = { icons = icons.lazy },

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
