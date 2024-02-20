local plugins = {
  -------------- UI stuff --------------
  require("plugins.ui.nvim-colorizer"),           -- colorized hex codes and color name
  require("plugins.ui.catppuccin"),               -- my favourte colorscheme
  require("plugins.ui.lualine"),                  -- extra status line on bottom
  require("plugins.ui.bufferline"),               -- use tabline show buffer list
  require("plugins.ui.barbecue"),                 -- use winbar show breadcrumbs
  require("plugins.ui.noice"),                    -- use float window show cmdline and messages
  require("plugins.ui.statuscol"),                -- manage status coloumn on left
  require("plugins.ui.nvim-ufo"),                 -- buffer fold guide
  -------------- Sidebar tools --------------
  require("plugins.sidebar.edgy"),            -- sidebar/bottom panel layout
  require("plugins.sidebar.neo-tree"),            -- file/buffer/git explorer
  require("plugins.sidebar.nvim-spectre"),        -- find and replace
  require("plugins.sidebar.outline"),             -- lsp document symbol outline
  -------------- Appearence --------------
  require("plugins.appearence.indent-blankline"), -- buffer indent guide
  require("plugins.appearence.mini-indent"),      -- current indent guide
  require("plugins.appearence.gitsigns"),         -- git integration in buffer
  require("plugins.appearence.todo-comments"),    -- highlight TODO-like comments
  require("plugins.appearence.treesitter"),       -- tree sitter
  -------------- Coding --------------
  require("plugins.coding.mason"),                -- LSP/DAP/Linter/Formatter manager
  { "mfussenegger/nvim-jdtls" },                  -- Java LSP
  { "nanotee/sqls.nvim" },                        -- SQL LSP
  require("plugins.coding.lspconfig"),            -- general LSP servers configuration
  require("plugins.coding.nvim-dap"),             -- general DAP debug configuration
  require("plugins.coding.none-ls"),              -- general Formatter/Linter configuration
  require("plugins.coding.LuaSnip"),              -- snippets
  require("plugins.coding.nvim-cmp"),             -- autocompletion
  require("plugins.coding.neotest"),              -- unit test
  require("plugins.coding.Comment"),              -- quick comment
  require("plugins.coding.markdown-preview"),     -- markdown preview
  require("plugins.coding.rest"),                 -- RESTful api client
  -------------- Tools --------------
  require("plugins.tools.which-key"),             -- show keys
  require("plugins.tools.nvim-autopairs"),        -- match parenthsis
  require("plugins.tools.guess-indent"),          -- guess what indent should be like
  require("plugins.tools.diffview"),              -- git diffview/mergetool
  require("plugins.tools.telescope"),             -- fuzzy finder
  require("plugins.tools.icon-picker"),           -- icon picker
  require("plugins.tools.floaterm"),              -- floating terminal
  require("plugins.tools.flash"),                 -- navigation in search/fFtT/treesitter
  require("plugins.tools.trouble"),               -- list all diagnositic && todos
  require("plugins.tools.project"),               -- project manager
  require("plugins.tools.auto-session"),          -- save/restore session
  require("plugins.tools.session-lens"),          -- search session
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
