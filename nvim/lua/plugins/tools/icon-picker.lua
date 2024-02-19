return {
    "ziontee113/icon-picker.nvim",
    dependencies = { "stevearc/dressing.nvim" },
    init = function()
        require("core.keymaps").load("iconpicker")
    end,
    cmd = "IconPickerNormal",
    config = function()
        require("icon-picker").setup({ disable_legacy_commands = true })
    end,
}
