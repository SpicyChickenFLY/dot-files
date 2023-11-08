-- Utilities for creating configurations
local util = require "formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    lua = { require("formatter.filetypes.lua").stylua },
    sh = { require("formatter.filetypes.sh").shfmt },
    sql = {
      function ()
        return { exe = "sqlfmt", args = { "-" }, stdin = true }
      end
    },
    python = { require("formatter.filetypes.python").black },
    markdown = { require("formatter.filetypes.markdown").prettierd },

    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      function()
        print('filetype:', vim.bo.filetype)
        local formatters = require("formatter.util").get_available_formatters_for_ft(vim.bo.filetype)
        if #formatters > 0 then
          print('available outside formatters')
          return
        end
        -- check if there are any LSP formatters
        local lsp_clients = vim.lsp.buf_get_clients()
        for cli_id, client in pairs(lsp_clients) do
          if client.server_capabilities.documentFormattingProvider then
            print('will use formattor inside lsp:' .. cli_id)
            vim.lsp.buf.format({ async = true })
            return
          end
        end
        return
        print('no available formatters')
      end,
    },
  }
}
