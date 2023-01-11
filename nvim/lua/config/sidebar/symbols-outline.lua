local opts = {
  highlight_hovered_item = true,
  show_guides = true,
  auto_preview = false,
  position = "right",
  relative_width = true,
  width = 25,
  auto_close = false,
  show_numbers = false,
  show_relative_numbers = false,
  show_symbol_details = true,
  preview_bg_highlight = "Pmenu",
  autofold_depth = nil,
  auto_unfold_hover = true,
  fold_markers = { "", "" },
  wrap = false,
  keymaps = { -- These keymaps can be a string or a table for multiple keys
    close = { "<Esc>", "q" },
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "<C-space>",
    toggle_preview = "K",
    rename_symbol = "r",
    code_actions = "a",
    fold = "h",
    unfold = "l",
    fold_all = "W",
    unfold_all = "E",
    fold_reset = "R",
  },
  lsp_blacklist = {},
  symbol_blacklist = {},
  symbols = {
    File = { hl = "TSURI" },
    Module = { hl = "TSNamespace" },
    Namespace = { hl = "TSNamespace" },
    Package = { hl = "TSNamespace" },
    Class = { hl = "TSType" },
    Method = { hl = "TSMethod" },
    Property = { hl = "TSMethod" },
    Field = { hl = "TSField" },
    Constructor = { hl = "TSConstructor" },
    Enum = { hl = "TSType" },
    Interface = { hl = "TSType" },
    Function = { hl = "TSFunction" },
    Variable = { hl = "TSConstant" },
    Constant = { hl = "TSConstant" },
    String = { hl = "TSString" },
    Number = { hl = "TSNumber" },
    Boolean = { hl = "TSBoolean" },
    Array = { hl = "TSConstant" },
    Object = { hl = "TSType" },
    Key = { hl = "TSType" },
    Null = { hl = "TSType" },
    EnumMember = { hl = "TSField" },
    Struct = { hl = "TSType" },
    Event = { hl = "TSType" },
    Operator = { hl = "TSOperator" },
    TypeParameter = { hl = "TSParameter" },
  },
}

local icons = require("core.icons")
for kind, _ in pairs(opts.symbols) do
  opts.symbols[kind].icon = icons.kind_icons[kind] or "?"
end

require("symbols-outline").setup(opts)
