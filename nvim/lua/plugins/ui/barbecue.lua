local icons = require("core.icons")
require("barbecue").setup({
  attach_navic = true,
  create_autocmd = true,
  include_buftypes = { "" },
  exclude_filetypes = { "toggleterm" },
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
