return {
    "ahmedkhalf/project.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    keys = require("core.keymaps")["project"],
    config = function()
        require("plugins.tools.project")
    end,
}
