local plugins = {
  'nvim-lua/plenary.nvim', -- basic algorithms
  'nvim-tree/nvim-web-devicons', -- character icons

  -- NOTE: themes
  { 'catppuccin/nvim',
    config = function() require('plugins.theme.catppuccin') end,
  }, -- lovely colorscheme

  -- NOTE: UI stuff
  { 'nvim-lualine/lualine.nvim',
    config = function() require('plugins.ui.lualine') end,
    lazy = false,
  }, -- statusline
  {'akinsho/bufferline.nvim',
    tag = "v3.*",
    config = function() require("plugins.ui.bufferline") end,
    lazy = false,
  }, -- tabline
  { "utilyre/barbecue.nvim",
    dependencies = {
      "kyazdani42/nvim-web-devicons", -- optional
      "neovim/nvim-lspconfig",
      "smiteshp/nvim-navic",
    },
    config = function() require("plugins.ui.barbecue") end,
  }, -- breadcrumbs

  -- NOTE: Appearence
  { 'nmac427/guess-indent.nvim',
    init = function() require("core.utils").lazy_load "guess-indent.nvim" end,
    config = function() require('guess-indent').setup {} end,
  }, -- guess what indent should be like
  { 'lukas-reineke/indent-blankline.nvim',
    config = function() require('plugins.appearence.indent-blankline') end,
  }, -- indent line
  { 'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'BufWinEnter',
    config = function() require('plugins.appearence.gitsigns') end,
  }, -- git column signs
  { 'folke/todo-comments.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function() require('plugins.appearence.todo-comments') end,
    event = 'BufWinEnter',
  }, -- todo highlights
  { 'NvChad/nvim-colorizer.lua',
    init = function()
      require("core.utils").lazy_load "nvim-colorizer.lua"
    end,
    config = function() require('colorizer').setup({}) end,
  }, -- colorized hex codes
  { 'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'theHamsta/crazy-node-movement',
      'windwp/nvim-ts-autotag',
      'HiPhish/nvim-ts-rainbow2',
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    run = ':TSUpdate',
    config = function() require('plugins.appearence.treesitter') end,
  },
  { 'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup({
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          })
        end,
      }
    },
    config = function() require('plugins.appearence.nvim-ufo') end,
  }, -- fold block
  { 'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end,
    event = 'BufWinEnter',
  }, -- quick comment

  -- NOTE: Language stuff
  { "williamboman/mason.nvim",
    config = function() require('mason').setup() end,
  }, -- LSP server collection installer
  { 'neovim/nvim-lspconfig',
    init = function() require("core.utils").lazy_load "nvim-lspconfig" end,
    dependencies = { 'b0o/schemastore.nvim' },
    config = function() require('plugins.lsp.lspconfig').setup() end,
  }, -- LSP server configuration
  { 'mfussenegger/nvim-jdtls' }, -- Java LSP
  { 'mfussenegger/nvim-lint',
    config = function () require('plugins.completion.lint') end,
  }, -- Linter
  { 'mhartington/formatter.nvim',
    config = function() require('plugins.completion.formatter') end,
  }, -- Formatter

  -- NOTE: Debugger
  { 'mfussenegger/nvim-dap',
    config = function() require('plugins.lsp.nvim-dap') end,
  }, -- dap client
  { "rcarriga/nvim-dap-ui",
    dependencies = {"mfussenegger/nvim-dap"},
  }, -- dap ui
  { "theHamsta/nvim-dap-virtual-text",
    config = function () require("nvim-dap-virtual-text").setup({}) end,
  }, -- dap virtual text


  -- NOTE: Completion stuff
  { 'hrsh7th/nvim-cmp',
    dependencies = {
      { 'L3MON4D3/LuaSnip',
        dependencies = { 'rafamadriz/friendly-snippets', },
        config = function() require('plugins.completion.luasnip') end,
      },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
    },
    config = function() require('plugins.completion.nvim-cmp') end,
    event = 'InsertEnter',
  }, -- autocompletion


  -- NOTE: Sidebar
  { 'kyazdani42/nvim-tree.lua',
    config = function() require('plugins.sidebar.nvim-tree') end,
    cmd = {
      'NvimTreeClipboard',
      'NvimTreeClose',
      'NvimTreeFindFile',
      'NvimTreeOpen',
      'NvimTreeRefresh',
      'NvimTreeToggle',
    },
    event = 'VimEnter',
  }, -- file explorer
  { 'windwp/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() require('plugins.sidebar.nvim-spectre') end,
  }, -- replacer

  -- NOTE: Tool stuff
  { "sindrets/diffview.nvim",
    config = function() require("plugins.tools.diffview") end
  }, -- git diffview/mergetool
  { 'nvim-telescope/telescope.nvim',
    event = 'BufWinEnter',
    dependencies = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', },
      'xiyaowong/telescope-emoji.nvim',
    },
    config = function() require('plugins.tools.telescope') end,
  }, -- fuzzy finder
  {"ziontee113/icon-picker.nvim",
    dependencies = {'stevearc/dressing.nvim'},
    config = function() require("icon-picker").setup{ disable_legacy_commands = true } end,
  },
  { 'voldikss/vim-floaterm',
    opt = true,
    event = 'BufWinEnter',
    config = function() require('plugins.tools.terminal') end,
  }, -- floating terminal
  { "folke/which-key.nvim",
    config = function() require('plugins.tools.which-key') end
  }, -- show keys
  { "kylechui/nvim-surround",
    config = function() require("nvim-surround").setup({}) end,
  },
  { "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },
  { 'phaazon/hop.nvim', branch = 'v2',
    config = function() require'hop'.setup { keys = 'asdfghjkl;qwertyuiopzxcvbnm' } end
  },
  { 'rest-nvim/rest.nvim',
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("plugins.tools.rest") end
  }, -- rest client
  { "tpope/vim-dadbod",
    dependencies = {
     "kristijanhusak/vim-dadbod-ui",
     "kristijanhusak/vim-dadbod-completion"
    },
    config = function() require("plugins.tools.dadbod") end,
  },
  { 'rmagatti/auto-session',
    config = function() require('plugins.tools.auto-session') end,
  } -- restore buffers
}

local config = {
  defaults = { lazy = true },
  install = { colorscheme = { "nvchad" } },

  ui = {
    icons = {
      ft = "",
      lazy = "󰂠 ",
      loaded = "",
      not_loaded = "",
    },
  },

  performance = {
    rtp = {
      disabled_plugins = {
        'netrw', 'netrwPlugin', 'netrwSettings', 'netrwFileHandlers', -- builtin file explorer
        'gzip', 'zip', 'zipPlugin', 'tar', 'tarPlugin', -- edit compressed files
        'getscript', 'getscriptPlugin',
        'vimball', 'vimballPlugin', -- create and unpack .vba files
        '2html_plugin', 'tohtml', -- convert a file with highlight to html
        'logipat', -- operators on pattern
        'rrhelper', -- remote wait editing
        'spellfile_plugin', -- downlload spell file
        'matchit', -- highlight
        'tutor', 'rplugin', 'syntax', 'synmenu', 'optwin', 'compiler', 'bugreport',
      },
    },
  },
}

require("lazy").setup(plugins, config)
