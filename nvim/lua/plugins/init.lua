local plugins = {
  -------------- UI stuff --------------
  require("plugins.ui.nvim-colorizer"),           -- colorized hex codes and color name
  require("plugins.ui.catppuccin"),               -- my favourte Colorscheme
  require("plugins.ui.lualine"),                  -- extra Status Line on bottom
  require("plugins.ui.bufferline"),               -- use Tabline show buffer list
  require("plugins.ui.barbecue"),                 -- use Winbar show breadcrumbs
  require("plugins.ui.noice"),                    -- use Float Window show cmdline and messages
  require("plugins.ui.statuscol"),                -- manage Status Coloumn on left
  require("plugins.ui.nvim-ufo"),                 -- buffer Fold guide
  -------------- Sidebar tools --------------
  require("plugins.sidebar.edgy"),                -- sidebar/bottom Panel Layout
  require("plugins.sidebar.neo-tree"),            -- File Explorer (also for buffer/git)
  require("plugins.sidebar.nvim-spectre"),        -- Find and Replace content
  require("plugins.sidebar.outline"),             -- LSP document symbol outline
  -------------- Appearence --------------
  require("plugins.appearence.indent-blankline"), -- buffer Indent guide
  require("plugins.appearence.mini-indent"),      -- cursor Indent guide
  require("plugins.appearence.gitsigns"),         -- Git integration in buffer
  require("plugins.appearence.todo-comments"),    -- highlight TODO-like Comments
  require("plugins.appearence.treesitter"),       -- TreeSitter for nvim
  -------------- Coding --------------
  require("plugins.coding.mason"),                -- LSP/DAP/Linter/Formatter manager
  { "mfussenegger/nvim-jdtls" },                  -- Java LSP
  { "nanotee/sqls.nvim" },                        -- SQL LSP
  require("plugins.coding.lspconfig"),            -- general LSP servers configuration
  require("plugins.coding.nvim-dap"),             -- general DAP debug configuration
  require("plugins.coding.none-ls"),              -- general Formatter/Linter configuration
  require("plugins.coding.LuaSnip"),              -- Snippets
  require("plugins.coding.nvim-cmp"),             -- Autocompletion
  require("plugins.coding.neotest"),              -- UnitTest framework
  require("plugins.coding.Comment"),              -- quick Comment
  -------------- Finder --------------
  require("plugins.tools.telescope"),             -- fuzzy Finder(file/buffer/keymap/highlight)
  require("plugins.tools.icon-picker"),           -- find Icon/NerdFont/Color
  require("plugins.tools.session-lens"),          -- find saved Session
  require("plugins.tools.project"),               -- find recent Project
  require("plugins.tools.trouble"),               -- list all diagnositic && todos
  require("plugins.tools.which-key"),             -- show keys
  -------------- Tools --------------
  require("plugins.tools.nvim-autopairs"),        -- match Parenthsis
  require("plugins.tools.guess-indent"),          -- guess what Indent should be like
  require("plugins.tools.diffview"),              -- Git diffview/mergetool
  require("plugins.tools.floaterm"),              -- floating terminal
  require("plugins.tools.flash"),                 -- Navigation in search/fFtT/treesitter
  require("plugins.tools.auto-session"),          -- save/restore Session
  require("plugins.coding.markdown-preview"),     -- markdown preview
  require("plugins.coding.rest"),                 -- HTTP request client
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
