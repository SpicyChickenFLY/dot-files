local defaults = {
    ensure_installed = {
        "c",
        "cpp",
        "go",
        "jsdoc",
        "lua",
        "markdown",
        "python",
        "sql",
        "scss",
        "css",
        "html",
        "http",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "xml",
        "yaml",
        "vue",
    },
    highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = false,
        disable = function(_, buf) -- omit lang
            local max_filesize = 100 * 1024 -- 100KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
    },
    indent = { enable = true, },
    autotag = { enable = true, },
    rainbow = {
        enable = true,
        query = {
            "rainbow-parens",
            vue = "rainbow-tags",
        },
        strategy = require("ts-rainbow").strategy.global,
        hlgroups = {
            "RainbowRed",
            "RainbowOrange",
            "RainbowYellow",
            "RainbowGreen",
            "RainbowBlue",
            "RainbowCyan",
            "RainbowViolet",
        },
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    node_movement = {
        enable = false,
        keymaps = {
            move_up = "<a-k>",
            move_down = "<a-j>",
            move_left = "<a-h>",
            move_right = "<a-l>",
            swap_left = "<s-a-h>", -- will only swap when one of "swappable_textobjects" is selected
            swap_right = "<s-a-l>",
            select_current_node = "<leader><Cr>",
        },
        swappable_textobjects = { "@function.outer", "@parameter.inner", "@statement.outer" },
        allow_switch_parents = true, -- more craziness by switching parents while staying on the same level, false prevents you from accidentally jumping out of a function
        allow_next_parent = true, -- more craziness by going up one level if next node does not have children
    },
}

require("nvim-treesitter.configs").setup(defaults)
