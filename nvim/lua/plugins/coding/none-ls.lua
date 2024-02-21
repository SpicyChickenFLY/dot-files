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
                null_ls.builtins.formatting.beautysh,
                null_ls.builtins.diagnostics.zsh.with({ filetypes = { "zsh" }, }),
                null_ls.builtins.hover.printenv.with({ filetypes = { "zsh", "bash", "sh", "dosbatch", "ps1" }, }),
                null_ls.builtins.diagnostics.shellcheck.with({ filetypes = { "bash", "sh" }, }),
                null_ls.builtins.code_actions.shellcheck.with({ filetypes = { "bash", "sh" }, }),
            },
        }
    end,
}
