require("catppuccin").setup({
    flavour = "latte", -- latte, frappe, macchiato, mocha
    background = { light = "latte", dark = "mocha" },
    transparent_background = false,
    show_end_of_buffer = false,
    term_colors = false,
    dim_inactive = { enabled = true, shade = "dark", percentage = 0.20 },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = function (colors)
        return {
            Folded = { fg = colors.blue, bg = colors.mantle }
        }
    end,
    integrations = {
        cmp = true,
        bufferline = true,
        gitsigns = true,
        hop = true,
        mason = true,
        neotest = true,
        noice = true,
        notify = true,
        nvimtree = true,
        treesitter_context = true,
        treesitter = true,
        ts_rainbow2 = true,
        symbols_outline = true,
        telescope = true,
        lsp_trouble = true,
        ufo = true,
        vim_sneak = false,
        which_key = true,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        dap = {
            enabled = true,
            enable_ui = true,
        },
        indent_blankline = {
            enabled = true,
            colored_indent_levels = true,
        },
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "undercurl" },
                hints = { "undercurl" },
                warnings = { "undercurl" },
                information = { "undercurl" },
            },
        },
    },
})

vim.cmd('colorscheme catppuccin-latte')
vim.cmd('colorscheme catppuccin-latte')
