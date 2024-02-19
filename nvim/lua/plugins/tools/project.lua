return {
    "ahmedkhalf/project.nvim",
    init = function()
        require("core.keymaps").load("project")
    end,
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    event = "VeryLazy",
    config = function()
        require("plugins.tools.project")
    end,
}
