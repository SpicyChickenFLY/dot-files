return {
  "catppuccin/nvim",
  lazy = false,
  config = function()
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
        conditionals = {},
        loops = {},
        functions = { "italic" },
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
      custom_highlights = function(colors)
        return {
          Folded = { fg = colors.blue, bg = colors.mantle },
        }
      end,
      integrations = {
        cmp = true,
        bufferline = true,
        dap = {
          enabled = true,
          enable_ui = true,
        },
        flash = true,
        gitsigns = true,
        mason = true,
        markdown = true,
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
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        treesitter_context = true,
        treesitter = true,
        ts_rainbow2 = true,
        symbols_outline = true,
        semantic_tokens = true,
        telescope = { enabled = true },
        lsp_trouble = true,
        ufo = true,
        vim_sneak = false,
        which_key = true,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        indent_blankline = {
          enabled = true,
          colored_indent_levels = true,
        },
      },
    })

    vim.cmd("colorscheme catppuccin-latte")
    vim.cmd("colorscheme catppuccin-latte")
  end,
}
