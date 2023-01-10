-- set highlight for diagnostic
local utils = require("core.utils")
local statusline_colors = utils.get_highlight("StatusLine")
local error_colors = utils.get_highlight("DiagnosticError")
local warning_colors = utils.get_highlight("DiagnosticWarn")
local hint_colors = utils.get_highlight("DiagnosticHint")
local info_colors = utils.get_highlight("DiagnosticInfo")
utils.set_highlight("DiagnosticErrorInv", { guibg = error_colors.guifg, guifg = statusline_colors.guibg })
utils.set_highlight("DiagnosticWarnInv", { guibg = warning_colors.guifg, guifg = statusline_colors.guibg })
utils.set_highlight("DiagnosticHintInv", { guibg = hint_colors.guifg, guifg = statusline_colors.guibg })
utils.set_highlight("DiagnosticInfoInv", { guibg = info_colors.guifg, guifg = statusline_colors.guibg })

vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint", numhl = "DiagnosticSignHint" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo", numhl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn", numhl = "DiagnosticSignWarn" })
vim.fn.sign_define( "DiagnosticSignError", { text = "", texthl = "DiagnosticSignError", numhl = "DiagnosticSignError" })


-- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
local border = "rounded"
vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border})
vim.lsp.handlers["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border })
vim.diagnostic.config({ float = { border = border } })
require('lspconfig.ui.windows').default_options = { border = border }

-- To instead override globally
-- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
-- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
--   opts = opts or {}
--   opts.border = opts.border or 'rounded'
--   return orig_util_open_floating_preview(contents, syntax, opts, ...)
-- end


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
require("lspconfig")["sumneko_lua"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
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

-- awk lsp
-------------
-- npm install -g awk-language-server
-- require('lspconfig')['awk_ls'].setup({
--   on_attach = on_attach,
--   flags = lsp_flags,
-- })

-- docker lsp
-------------
-- npm install -g dockerfile-language-server-nodejs
-- require("lspconfig")["dockerls"].setup({
--   on_attach = on_attach,
--   flags = lsp_flags,
-- })

-- ansible lsp
-------------
-- npm install -g @ansible/ansible-language-server
require("lspconfig")["ansiblels"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
})

-- vue lsp
-------------
require("lspconfig")["vuels"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
})
--[[ require("lspconfig")["volar"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
  filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
  cmd = { "vue-language-server", "--stdio" },
  init_options = {
    documentFeatures = {
      documentColor = false,
      documentFormatting = {
        defaultPrintWidth = 100,
      },
      documentSymbol = true,
      foldingRange = true,
      linkedEditingRange = true,
      selectionRange = true,
    },
    languageFeatures = {
      callHierarchy = true,
      codeAction = true,
      codeLens = true,
      completion = {
        defaultAttrNameCase = "kebabCase",
        defaultTagNameCase = "both",
      },
      definition = true,
      diagnostics = true,
      documentHighlight = true,
      documentLink = true,
      hover = true,
      implementation = true,
      references = true,
      rename = true,
      renameFileRefactoring = true,
      schemaRequestService = true,
      semanticTokens = false,
      signatureHelp = true,
      typeDefinition = true,
    },
    typescript = {
      tsdk = "",
    },
  },
}) ]]

-- javascript/typescript lsp
-------------
-- npm i -g vscode-langservers-extracted
require("lspconfig")["eslint"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
})

-- html lsp
-------------
-- npm i -g vscode-langservers-extracted
require("lspconfig")["html"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
})

-- css lsp
-------------
-- npm i -g vscode-langservers-extracted
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

-- java lsp
-------------
-- NOTE: java-language-server only support jdk(>=1.9)
-- https://github.com/georgewfraser/java-language-server
-- require('lspconfig')['java_language_server'].setup({
--   cmd = {"/mnt/Mine/Code/java/java-language-server/dist/lang_server_linux.sh"},
--   on_attach = on_attach,
--   flags = lsp_flags,
-- })
--
-- NOTE: jdtls should be setup by nvim-jdtls
-- require('lspconfig')['jdtls'].setup({
--   on_attach = on_attach,
--   flags = lsp_flags,
-- })

-- cmake lsp
-------------
-- pip install cmake-language-server
--[[ require('lspconfig')['cmake'].setup({ ]]
--[[   on_attach = on_attach, ]]
--[[   flags = lsp_flags, ]]
--[[ }) ]]
