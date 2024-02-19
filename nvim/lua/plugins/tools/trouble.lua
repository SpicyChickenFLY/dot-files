return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
        require("core.keymaps").load("trouble")
    end,
    cmd = {
        "Trouble",
        "TroubleClose",
        "TroubleToggle",
        "TroubleRefresh",
    },
}
