local plugins = {
  -------------- UI stuff --------------
  -- require("plugins.ui.nvim-colorizer"),       -- colorized hex codes and color name
  require("plugins.ui.catppuccin"),           -- my favourte Colorscheme
  require("plugins.ui.lualine"),              -- extra Status Line on bottom
  require("plugins.ui.bufferline"),           -- use Tabline show buffer list
  require("plugins.ui.barbecue"),             -- use Winbar show breadcrumbs
  require("plugins.ui.statuscol"),            -- manage Status Coloumn on left
  require("plugins.ui.nvim-ufo"),             -- buffer Fold guide
  require("plugins.ui.indent-blankline"),     -- buffer Indent guide
  require("plugins.ui.mini-indent"),          -- cursor Indent guide
  -------------- Sidebar tools --------------
  require("plugins.sidebar.nvim-spectre"),    -- Find and Replace content
  require("plugins.sidebar.outline"),         -- LSP document symbol outline
  require("plugins.sidebar.neotest"),         -- UnitTest framework
  -------------- Coding --------------
  require("plugins.coding.mason"),            -- LSP/DAP/Linter/Formatter manager
  require("plugins.coding.flutter-tools"),    -- Flutter LSP Tool
  { "mfussenegger/nvim-jdtls" },              -- Java LSP Tool
  -- require("plugins.coding.nvim-java"),         -- general DAP debug configuration
  { "nanotee/sqls.nvim" },                    -- SQL LSP Tool
  require("plugins.coding.lspconfig"),        -- general LSP servers configuration
  require("plugins.coding.nvim-dap"),         -- general DAP debug configuration
  require("plugins.coding.none-ls"),          -- general Formatter/Linter configuration
  require("plugins.coding.LuaSnip"),          -- Snippets
  require("plugins.coding.nvim-cmp"),         -- Autocompletion
  require("plugins.coding.Comment"),          -- quick Comment
  require("plugins.coding.todo-comments"),    -- highlight TODO-like Comment
  require("plugins.coding.treesitter"),       -- TreeSitter for nvim
  -- require("plugins.coding.lsp-signature"),    -- Show function signature when you type
  -- require("plugins.coding.navigator"),        -- code Analysis & Navigation tool
  require("plugins.coding.markdown-preview"), -- Markdown preview
  require("plugins.coding.rest"),             -- HTTP request client
  -------------- Finder --------------
  require("plugins.finder.telescope"),        -- fuzzy Finder(file/buffer/keymap/highlight)
  require("plugins.finder.icon-picker"),      -- find Icon/NerdFont/Color
  require("plugins.finder.session-lens"),     -- find saved Session
  require("plugins.finder.trouble"),          -- find all Diagnositic && TODO-like Comment
  require("plugins.finder.which-key"),        -- find triggerd Keymaps
  -------------- Tools --------------
  require("plugins.tools.nvim-autopairs"),    -- match Parenthsis
  require("plugins.tools.guess-indent"),      -- guess what Indent should be like
  require("plugins.tools.gitsigns"),          -- Git integration in buffer
  require("plugins.tools.diffview"),          -- Git diffview/mergetool
  require("plugins.tools.floaterm"),          -- floating terminal
  require("plugins.tools.flash"),             -- Navigation in search/fFtT/treesitter
  require("plugins.tools.auto-session"),      -- save/restore Session
}

local disabled_builtin_plugins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "tohtml",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit",
  "tutor",
  "rplugin",
  "syntax",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
}
-- lazy.nvim config
local config = {
  defaults = { lazy = true, version = false },
  install = { colorscheme = { "catppuccin-latte" } },
  performance = { rtp = { disabled_plugins = disabled_builtin_plugins } },
}

require("lazy").setup(plugins, config)
