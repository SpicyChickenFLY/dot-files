local highlight = {
    "RainbowRed",
    "RainbowOrange",
    "RainbowYellow",
    "RainbowGreen",
    "RainbowBlue",
    "RainbowViolet",
    "RainbowCyan",
}
local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#EA76CB" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#FE640B" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#DF8E1D" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#40A02B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#04A5E5" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#209FB5" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#8839ef" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup { scope = { highlight = highlight } }

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
