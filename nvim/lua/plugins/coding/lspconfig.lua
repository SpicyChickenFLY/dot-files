return {
  'neovim/nvim-lspconfig',
  keys = require('core.keymaps')["lspconfig"],
  dependencies = {
    'b0o/schemastore.nvim',
  },
  config = function()
    local utils = require("core.utils")
    local icons = require("core.icons")

    -- disable some default providers
    for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
      vim.g["loaded_" .. provider .. "_provider"] = 0
    end

    -- set highlight and icon for diagnostic
    local statusline_colors = utils.get_highlight("StatusLine")
    local diagnostic_type = { "Error", "Warn", "Info", "Hint" }
    local diagnostic_icon_map = { Error = icons.error, Warn = icons.warn, Info = icons.info, Hint = icons.hint }
    for _, value in ipairs(diagnostic_type) do
      local color = utils.get_highlight("Diagnostic" .. value)
      utils.set_highlight("Diagnostic" .. value .. "Inv", { guibg = color.guifg, guifg = statusline_colors.guibg })
      local diag_sign_key = "DiagnosticSign" .. value
      local icon = diagnostic_icon_map[value]
      vim.fn.sign_define(diag_sign_key, { text = icon, texthl = diag_sign_key, numhl = diag_sign_key })
    end

    -- set lsp-config
    local border = "rounded"
    vim.diagnostic.config({
      float = { border = border },
      signs = false;
      severity_sort  = true,
      virtual_text = true,
      virtual_lines = false,
      -- ["my/notify"] = {log_level = vim.log.levels.HINT}
    })
    require("lspconfig.ui.windows").default_options = { border = border }

    local kinds = vim.lsp.protocol.CompletionItemKind
    for i, kind in ipairs(kinds) do
      kinds[i] = icons.kind_icons[kind] or kind
    end

    -- Use an on_attach function to only map the following keys after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

      vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
          local opts = {
            focusable = false,
            close_events = {
              "BufLeave",
              "BufHidden",
              "CursorMoved",
              "CursorMovedI",
              "InsertEnter",
              "FocusLost",
              "WinLeave",
            },
            border = "rounded",
            source = "always",
            prefix = " ",
            scope = "cursor",
          }
          vim.diagnostic.open_float(nil, opts)
        end,
      })

      if client.server_capabilities.documentHighlightProvider then
        -- vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        -- vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
        vim.api.nvim_create_autocmd("CursorHold", {
          callback = vim.lsp.buf.document_highlight,
          buffer = bufnr,
          -- group = "lsp_document_highlight",
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
          callback = vim.lsp.buf.clear_references,
          buffer = bufnr,
          -- group = "lsp_document_highlight",
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
    -- vue/typescirpt lsp
    local util = require("lspconfig.util")
    local function get_typescript_server_path(root_dir)
      local global_ts = vim.fn.stdpath("data") .. "/lsp_servers/tsserver/node_modules/typescript/lib"
      local found_ts = ""
      local function check_dir(path)
        found_ts = util.path.join(path, "node_modules", "typescript", "lib")
        if util.path.exists(found_ts) then
          return path
        end
      end
      if util.search_ancestors(root_dir, check_dir) then
        return found_ts
      else
        return global_ts
      end
    end
    require("lspconfig")["volar"].setup({
      on_attach = on_attach,
      filetypes = { "javascript", "typescript", "vue" },
      on_new_config = function(new_config, new_root_dir)
        local ts_server_path = get_typescript_server_path(new_root_dir)
        new_config.init_options.typescript.tsdk = ts_server_path
      end,
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
    -- C/C++
    require("lspconfig").clangd.setup({ on_attach = on_attach })
    -- Python
    require("lspconfig").pyright.setup({ on_attach = on_attach })
    -- Bash
    require("lspconfig").bashls.setup({ on_attach = on_attach })
    -- XML
    require("lspconfig").lemminx.setup({ on_attach = on_attach })
    -- SQL
    -- require("lspconfig").sqlls.setup({ on_attach = on_attach })
    require("lspconfig").sqls.setup({ on_attach = on_sql_attach })
  end,
}
