return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    key = require("core.keymaps")["trouble"],
    cmd = {
        "Trouble",
        "TroubleClose",
        "TroubleToggle",
        "TroubleRefresh",
    },
}
