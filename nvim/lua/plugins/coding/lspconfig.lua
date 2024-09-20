return {
  'neovim/nvim-lspconfig',
  keys = require('core.keymaps')["lspconfig"],
  dependencies = {
    'b0o/schemastore.nvim',
  },
  config = function()
    local icons = require("core.icons")

    -- disable some default providers
    for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
      vim.g["loaded_" .. provider .. "_provider"] = 0
    end

    -- set highlight and icon for diagnostic
    -- local statusline_colors = vim.api.nvim_command_output(('hi %s'):format("StatusLine"))
    local diagnostic_type = { "Error", "Warn", "Info", "Hint" }
    local diagnostic_icon_map = { Error = icons.error, Warn = icons.warn, Info = icons.info, Hint = icons.hint }
    for _, value in ipairs(diagnostic_type) do

      local diag_sign_key = "DiagnosticSign" .. value
      local icon = diagnostic_icon_map[value]
      vim.fn.sign_define(diag_sign_key, { text = icon, texthl = diag_sign_key, numhl = diag_sign_key })
    end

    -- set lsp-config
    local border = "rounded"
    vim.diagnostic.config({
      float         = { border = border },
      signs         = true,
      severity_sort = true,
      virtual_text  = true,
      virtual_lines = false,
      -- ["my/notify"] = {log_level = vim.log.levels.HINT}
    })
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })
    require("lspconfig.ui.windows").default_options = { border = border }

    local kinds = vim.lsp.protocol.CompletionItemKind
    for i, kind in ipairs(kinds) do
      kinds[i] = icons.kind_icons[kind] or kind
    end

    -- Use an on_attach function to only map the following keys after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)

      if client.server_capabilities.documentHighlightProvider then
        local augroup = "lsp_document_highlight"
        vim.api.nvim_create_augroup(augroup, { clear = true })
        vim.api.nvim_clear_autocmds({ buffer = bufnr, group = augroup })
        vim.api.nvim_create_autocmd("CursorHold", {
          callback = vim.lsp.buf.document_highlight,
          buffer = bufnr,
          group = augroup,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
          callback = vim.lsp.buf.clear_references,
          buffer = bufnr,
          group = augroup,
        })
      end
    end

    local on_sql_attach = function(client, bufnr)
      vim.api.nvim_create_autocmd('User', {
        pattern = 'SqlsConnectionChoice',
        callback = function(event)
          -- 提取连接中的dsn信息
          -- vim.g.sqls_connection_choice = event.data.choice
          local results = vim.split(event.data.choice, ' ')
          vim.g.sqls_driver_type = results[2]
          vim.g.sqls_connection_choice = results[3]
          local dsn = results[4]
          if #results == 4 then dsn = results[4] end

          local split = vim.split(dsn, "://")
          split = vim.split(split[#split], '/')
          vim.g.sqls_database_choice = split[#split]
          if results[3] == '' then
            table.remove(split)
            vim.g.sqls_connection_choice = table.concat(split, '/')
          end
        end,
      })
      vim.api.nvim_create_autocmd('User', {
        pattern = 'SqlsDatabaseChoice',
        callback = function(event)
          vim.g.sqls_database_choice = event.data.choice
        end,
      })
      require("core.keymaps").sqls(bufnr)
      require('sqls').on_attach(client, bufnr)
      vim.cmd([[ SqlsSwitchConnection ]])
    end

    -- go lsp
    require("lspconfig")["gopls"].setup({
      on_attach = on_attach,
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
        codelenses = { gc_details = true, tidy = true },
      },
    })
    -- lua lsp
    require("lspconfig")["lua_ls"].setup({
      on_attach = on_attach,
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim" } },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
              [vim.fn.stdpath("data") .. "/lazy"] = true,
              -- library = vim.api.nvim_get_runtime_file("", true),
            },
            checkThirdParty = "Disable",
          },
          telemetry = { enable = false },
        },
      },
    })
    -- Vue/TypeScript lsp
    require('lspconfig')["ts_ls"].setup {
      filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact' },
    }
    -- local vue_language_server_path = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
    -- require('lspconfig')["tsserver"].setup {
    --   init_options = {
    --     plugins = {
    --       {
    --         name = '@vue/typescript-plugin',
    --         location = vue_language_server_path,
    --         languages = { 'vue' },
    --       },
    --     },
    --   },
    --   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    -- }
    -- No need to set `hybridMode` to `true` as it's the default value
    -- require('lspconfig')["volar"].setup {
    --   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    --   init_options = {
    --     vue = {
    --       hybridMode = false,
    --     },
    --   },
    -- }
    require('lspconfig')["vuels"].setup {
      init_options = {
        vue = {
          config = {
            css = {},
            emmet = {},
            html = { suggest = {} },
            javascript = { format = {} },
            stylusSupremacy = {},
            typescript = { format = {} },
            vetur = {
              completion = {
                autoImport = false,
                tagCasing = "kebab",
                useScaffoldSnippets = false
              },
              format = {
                defaultFormatter = { js = "none", ts = "none" },
                defaultFormatterOptions = {},
                scriptInitialIndent = false,
                styleInitialIndent = false
              },
              useWorkspaceDependencies = false,
              validation = {
                script = true,
                style = true,
                template = true
              }
            }
          }
        },
      },
    }
    -- javascript/typescript/html/css lsp
    require("lspconfig")["eslint"].setup({
      on_attach = function(client, bufnr)
        local group = vim.api.nvim_create_augroup("Eslint", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = group,
          pattern = "<buffer>",
          command = "EslintFixAll",
          desc = "Run eslint when saving buffer.",
        })
        on_attach(client, bufnr) -- declared elsewhere
      end,
    })
    require("lspconfig").stylelint_lsp.setup({ on_attach = on_attach })
    -- json lsp
    require("lspconfig")["jsonls"].setup({
      on_attach = on_attach,
      settings = {
        json = { schemas = require("schemastore").json.schemas() },
      },
    })
    -- -- Java
    -- local jdk8_path = "/usr/local/jdk8"
    -- local jdk17_path = "/usr/local/jdk17"
    -- local java_debug_path = "/usr/local/java-debug"
    -- local java_decompiler_path = "/usr/local/java-decompiler"
    -- local bundles = {
    --   vim.fn.glob(java_debug_path .. "/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1),
    -- }
    -- vim.list_extend(bundles, vim.split(vim.fn.glob(java_decompiler_path .. "/server/*.jar", 1), "\n"))
    --
    -- require('lspconfig').jdtls.setup({
    --   -- Here you can configure eclipse.jdt.ls specific settings
    --   -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    --   -- for a list of options
    --   settings = {
    --     java = {
    --       runtimes = {
    --         { name = "javaSE-8",  path = jdk8_path },
    --         { name = "javaSE-17", path = jdk17_path },
    --       },
    --       contentProvider = { preferred = "fernflower" },
    --     },
    --   },
    --
    --   -- Language server `initializationOptions`
    --   -- You need to extend the `bundles` with paths to jar files
    --   -- init_options = { bundles = bundles },
    --   -- command = "vscode.java.startDebugSession",
    --   on_attach = on_attach
    -- })
    -- C/C++
    require("lspconfig").clangd.setup({ on_attach = on_attach })
    -- Python
    require("lspconfig").pyright.setup({
      on_attach = on_attach,
      settings = {
        python = {
          venvPath = "/mnt/Mine/Code/python/venv/"
        }
      }
    })
    -- Bash
    require("lspconfig").bashls.setup({ on_attach = on_attach })
    -- XML
    require("lspconfig").lemminx.setup({ on_attach = on_attach })
    -- SQL
    -- require("lspconfig").sqlls.setup({ on_attach = on_attach })
    require("lspconfig").sqls.setup({ on_attach = on_sql_attach })
  end,
}
