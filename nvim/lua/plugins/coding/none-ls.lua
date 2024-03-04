return {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
        local null_ls = require("null-ls")
        return {
            diagnostics_format = "#{m} (#{s})",
            sources = {
                -- cpp
                null_ls.builtins.diagnostics.cppcheck.with({
                    extra_args = {
                        "--inconclusive",
                    },
                }),
                -- python
                null_ls.builtins.diagnostics.pylint,
                null_ls.builtins.formatting.black,
                -- lua
                -- null_ls.builtins.formatting.stylua,
                -- golang
                null_ls.builtins.formatting.goimports,
                -- golang
                null_ls.builtins.formatting.goimports,
                -- shell
                null_ls.builtins.formatting.shfmt,
                null_ls.builtins.diagnostics.zsh.with({ filetypes = { "zsh" }, }),
                null_ls.builtins.hover.printenv.with({ filetypes = { "zsh", "bash", "sh", "dosbatch", "ps1" }, }),
            },
        }
    end,
}
