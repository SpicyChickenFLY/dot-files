local utils = require("core.utils")
local icons = require("core.icons")

-- set highlight for diagnostic
local statusline_colors = utils.get_highlight("StatusLine")
local error_colors = utils.get_highlight("DiagnosticError")
local warning_colors = utils.get_highlight("DiagnosticWarn")
local hint_colors = utils.get_highlight("DiagnosticHint")
local info_colors = utils.get_highlight("DiagnosticInfo")
utils.set_highlight("DiagnosticErrorInv", { guibg = error_colors.guifg, guifg = statusline_colors.guibg })
utils.set_highlight("DiagnosticWarnInv", { guibg = warning_colors.guifg, guifg = statusline_colors.guibg })
utils.set_highlight("DiagnosticHintInv", { guibg = hint_colors.guifg, guifg = statusline_colors.guibg })
utils.set_highlight("DiagnosticInfoInv", { guibg = info_colors.guifg, guifg = statusline_colors.guibg })

vim.fn.sign_define("DiagnosticSignHint",
  { text = icons.hint, texthl = "DiagnosticSignHint", numhl = "DiagnosticSignHint" })
vim.fn.sign_define("DiagnosticSignInfo",
  { text = icons.info, texthl = "DiagnosticSignInfo", numhl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignWarn",
  { text = icons.warn, texthl = "DiagnosticSignWarn", numhl = "DiagnosticSignWarn" })
vim.fn.sign_define( "DiagnosticSignError",
  { text = icons.error, texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" })

local border = "rounded"
vim.diagnostic.config({
  float = { border = border },
  virtual_text = { enable = false, },
})
require("lspconfig.ui.windows").default_options = { border = border }

local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(kinds) do
  kinds[i] = icons.kind_icons[kind] or kind
end

-- Use an on_attach function to only map the following keys after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

-- This is the default in Nvim 0.7+
local lsp_flags = {
  debounce_text_changes = 150,
}

-- c/c++ lsp
-------------
require("lspconfig")["ccls"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
})

-- go lsp
-------------
-- go install golang.org/x/tools/gopls@latest
require("lspconfig")["gopls"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
  init_options = {
    gofumpt = true,
    usePlaceholders = true,
    semanticTokens = true,
    staticcheck = true,
    experimentalPostfixCompletions = false,
    hoverKind = "FullDocumentation",
    analyses = {
      nilness = true,
      shadow = true,
      unusedparams = true,
      unusedwrite = true,
      fieldalignment = true,
    },
    codelenses = {
      gc_details = true,
      tidy = true,
    },
  },
})

-- rust lsp
-------------
-- sudo pacman -S rust-analyzer
require("lspconfig")["rust_analyzer"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy",
      },
    },
  },
})

-- python lsp
-------------
-- npm i -g pyright
require("lspconfig")["pyright"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
})

-- lua lsp
-------------
-- sudo pacman -S lua-language-server
require("lspconfig")["lua_ls"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", },
      diagnostics = { globals = { "vim" }, },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})

-- vim lsp
-------------
-- npm install -g vim-language-server
require("lspconfig")["vimls"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
})

-- typescript lsp
-------------
-- npm install -g typescript typescript-language-server
--[[ require('lspconfig')['tsserver'].setup({ ]]
--[[   on_attach = on_attach, ]]
--[[   flags = lsp_flags, ]]
--[[ }) ]]

-- bash lsp
-------------
-- npm i -g bash-language-server
require("lspconfig")["bashls"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
})

-- vue lsp
-------------
require("lspconfig")["vuels"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
})

-- javascript/typescript/html/css lsp
-------------
-- npm i -g vscode-langservers-extracted
require("lspconfig")["eslint"].setup({
  on_attach = function (client, bufnr)
    local group = vim.api.nvim_create_augroup("Eslint", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = group,
      pattern = "<buffer>",
      command = "EslintFixAll",
      desc = "Run eslint when saving buffer.",
    })
    on_attach(client, bufnr) -- declared elsewhere
  end,
  flags = lsp_flags,
})
require("lspconfig")["html"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
})
require("lspconfig")["cssls"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
})

-- yaml lsp
-------------
-- -- yarn global add yaml-language-server
-- require('lspconfig')['yamlls'].setup({
--   on_attach = on_attach,
--   flags = lsp_flags,
--   settings = {
--     yaml = {
--       schemas = require('schemastore').json.schemas(),
--     },
--   },
-- })

-- json lsp
-------------
-- npm i -g vscode-langservers-extracted
-- require('lspconfig')['jsonls'].setup({
--   on_attach = on_attach,
--   flags = lsp_flags,
--   settings = {
--     json = {
--       schemas = require('schemastore').json.schemas(),
--     },
--   },
-- })

-- sql lsp
-------------
-- npm i -g sql-language-server
require("lspconfig")["jsonls"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
})

-- java lsp  NOTE: jdtls should be setup by nvim-jdtls

vim.api.nvim_create_autocmd("CursorHold", {
  buffer = bufnr,
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = " ",
      scope = "cursor",
    }
    vim.diagnostic.open_float(nil, opts)
  end,
})
