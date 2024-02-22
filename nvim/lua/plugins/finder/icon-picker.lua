return {
    "ziontee113/icon-picker.nvim",
    dependencies = { "stevearc/dressing.nvim" },
    keys = {
        { "<leader>fi", ":IconPickerNormal nerd_font_v3 alt_font emoji symbols html_colors<CR>", desc = "Find Icon" },
    },
    cmd = "IconPickerNormal",
    config = function()
        require("icon-picker").setup({ disable_legacy_commands = true })
    end,
}
