return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async',
    "luukvbaal/statuscol.nvim",
  },
  keys = require("core.keymaps")["ufo"],
  event = 'BufWinEnter',
  config = function()
    local handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = (" ↙ %d "):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, { chunkText, hlGroup })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          -- str width returned from truncate() may less than 2nd argument, need padding
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      table.insert(newVirtText, { suffix, "MoreMsg" })
      return newVirtText
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
    }
    -- find by lsp (or list servers manually like {'gopls', 'clangd'})
    -- local language_servers = require("lspconfig").util.available_servers()
    -- local language_servers = {'yamlls'}
    -- for _, ls in ipairs(language_servers) do
    --     require('lspconfig')[ls].setup({
    --         capabilities = capabilities
    --         -- you can add other fields for setting up lsp server in this table
    --     })
    -- end

    require("ufo").setup({
    open_fold_hl_timeout = 400,
      close_fold_kinds_for_ft = {
        java = { "imports" }
      },
      --[[ provider_selector = function(bufnr, filetype, buftype) ]]
      provider_selector = function(_, _, _) return { "lsp" } end,
      fold_virt_text_handler = handler,
      enable_get_fold_virt_text = true,
      preview = {},
    })
  end,
}
