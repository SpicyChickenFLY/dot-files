local icons = require("core.icons")

return {
  "utilyre/barbecue.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional
    "neovim/nvim-lspconfig",
    "smiteshp/nvim-navic",
  },
  event = 'BufWinEnter',
  config = function()
    require("barbecue").setup({
      attach_navic = true,
      create_autocmd = true,
      include_buftypes = { "" },
      exclude_filetypes = { "toggleterm", "vue" },
      truncation = { enabled = true, method = "keep_basename", },
      modifiers = { dirname = ":~:.", basename = "", },
      custom_section = function() return "" end,
      symbols = {
        modified = false,
        ellipsis = icons.ellipsis,
        separator = ">",
      },

      kinds = icons.kind_icons
    })
  end,
}
