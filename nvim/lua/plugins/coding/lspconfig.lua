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
    -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    --   border = "rounded",
    -- })
    require("lspconfig.ui.windows").default_options = { border = border }

    local kinds = vim.lsp.protocol.CompletionItemKind
    for i, kind in ipairs(kinds) do
      kinds[i] = icons.kind_icons[kind] or kind
    end

    -- Use an on_attach function to only map the following keys after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
    end

    -- go lsp
    require("lspconfig")["gopls"].setup({
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
      end,
    })
    require("lspconfig").stylelint_lsp.setup({})
    -- json lsp
    require("lspconfig")["jsonls"].setup({
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
      -- vim.fn.glob(java_debug_path .. "/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", false),
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
    require("lspconfig").clangd.setup({ })
    -- Python
    require("lspconfig").pyright.setup({
      settings = {
        python = {
          -- venv = "venv",
          -- venvPath = "/mnt/Mine/Code/python/",
          pythonPath = "/mnt/Mine/Code/python/venv/bin/python"
        }
      }
    })
    -- Bash
    require("lspconfig").bashls.setup({ })
    -- XML
    require("lspconfig").lemminx.setup({ })
    -- SQL
    -- require("lspconfig").sqlls.setup({ })
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
    require("lspconfig").sqls.setup({ on_attach = on_sql_attach })
  end,
}
