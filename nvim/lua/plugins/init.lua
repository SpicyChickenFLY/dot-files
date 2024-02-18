local plugins = {
  { "nvim-lua/plenary.nvim", lazy = true }, -- nvim algorithm library
  { 'kevinhwang91/promise-async', lazy = true }, -- async promise support

  -------------- UI stuff --------------
  { "MunifTanjim/nui.nvim", lazy = true }, -- ui components library
  { "stevearc/dressing.nvim", lazy = true }, -- beautiful vim.ui
  { "nvim-tree/nvim-web-devicons", lazy = true }, -- icons for develop
  { 'NvChad/nvim-colorizer.lua',
    event = 'BufWinEnter',
    config = function() require('colorizer').setup({}) end,
  } , -- colorized hex codes and color name
  require "plugins.ui.catppuccin", -- my favourte colorscheme
  require "plugins.ui.lualine", -- extra status line on bottom
  require "plugins.ui.bufferline", -- use tabline show buffer list
  require "plugins.ui.barbecue", -- use winbar show breadcrumbs
  require "plugins.ui.noice", -- use float window show cmdline and messages
  require "plugins.ui.statuscol", -- manage status coloumn on left
  require "plugins.ui.nvim-ufo", -- buffer fold guide

  -------------- Sidebar stuff --------------
  require "plugins.sidebar.neo-tree", -- file/buffer/git explorer
  require "plugins.sidebar.nvim-spectre", -- find and replace
  require "plugins.sidebar.outline", -- outline
  require "plugins.sidebar.nvim-dap", -- debug

  -------------- Appearence --------------
  require "plugins.appearence.indent-blankline", -- buffer indent guide
  require "plugins.appearence.mini-indent", -- current indent guide
  require "plugins.appearence.gitsigns", -- git integration in buffer
  require "plugins.appearence.todo-comments", -- highlight TODO-like comments
  require "plugins.appearence.treesitter", -- tree sitter

  -- NOTE: LSP staff
  require "plugins.lsp.mason", -- LSP/DAP/Linter/Formatter manager
  {
    'neovim/nvim-lspconfig',
    init = function() require('core.keymaps').load "lspconfig" end,
    dependencies = { 'b0o/schemastore.nvim' },
    config = function() require('plugins.lsp.lspconfig') end,
  }, -- LSP server configuration
  { 'mfussenegger/nvim-jdtls' }, -- Java LSP
  { 'nanotee/sqls.nvim' }, -- SQL LSP
  { 'stevearc/conform.nvim', opts = {}, },
  {
    'mhartington/formatter.nvim',
    init = function() require('core.keymaps').load "formatter" end,
    cmd = "FormatWrite",
    config = function() require('plugins.lsp.formatter') end,
  }, -- Formatter
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
      "nvim-neotest/neotest-go",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "VeryLazy",
    init = function() require('core.keymaps').load "neotest" end,
    config = function() require('plugins.lsp.neotest') end,
  }, -- unit test

  -- NOTE: Tool stuff
  require "plugins.tools.which-key", -- show keys
  {
    'nmac427/guess-indent.nvim',
    event = 'BufWinEnter',
    config = function() require('guess-indent').setup {} end,
  }, -- guess what indent should be like
  {
    'numToStr/Comment.nvim',
    event = 'BufWinEnter',
    config = function() require('Comment').setup({
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    }) end,
  }, -- quick comment
  {
    "windwp/nvim-autopairs",
    event = "BufWinEnter",
    config = function() require("nvim-autopairs").setup {} end
  }, -- auto pair
  -- {
  --   "kylechui/nvim-surround",
  --   event = "BufWinEnter",
  --   config = function() require("nvim-surround").setup({}) end,
  -- }, -- surround signs
  {
    "sindrets/diffview.nvim",
    init = function() require('core.keymaps').load "diffview" end,
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
    init = function() require('core.keymaps').load "telescope" end,
    cmd = "Telescope",
    config = function() require('plugins.tools.telescope') end,
  }, -- fuzzy finder
  {
    "ziontee113/icon-picker.nvim",
    dependencies = { 'stevearc/dressing.nvim' },
    init = function() require('core.keymaps').load "iconpicker" end,
    cmd = "IconPickerNormal",
    config = function() require("icon-picker").setup { disable_legacy_commands = true } end,
  }, -- icon picker
  {
    'voldikss/vim-floaterm',
    init = function() require('core.keymaps').load "floaterm" end,
    cmd = { "FloatermNew", "FloatermToggle" },
    config = function() require('plugins.tools.floaterm') end,
  }, -- floating terminal
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    'rest-nvim/rest.nvim',
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "",
    config = function() require("plugins.tools.rest") end
  }, -- rest client
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
    init = function() require('core.keymaps').load "autosession" end,
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
    init = function() require('core.keymaps').load "trouble" end,
    cmd = {
      "Trouble",
      "TroubleClose",
      "TroubleToggle",
      "TroubleRefresh",
    }
  }, -- list all diagnositic && todos
  {
    "ahmedkhalf/project.nvim",
    init = function() require('core.keymaps').load "project" end,
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    event = "VeryLazy",
    config = function() require('plugins.tools.project') end,
  }, -- project manager
}


local config = {
  defaults = { lazy = true, version = false },
  install = { colorscheme = { "catppuccin-latte" } },

  performance = {
    rtp = {
      -- [[ 禁用vim的一些内置插件 ]]
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
