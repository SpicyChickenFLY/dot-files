
return {
  "sindrets/diffview.nvim",
  keys = require("core.keymaps")["diffview"],
  cmd = { "DiffviewOpen", "DiffviewToggleFiles", "DiffviewFileHistory" },
  config = function()
    require("diffview").setup({
      view = { default = {
          winbar_info = true,
        },
        file_history = {
          winbar_info = true,
        },
      },
    })
  end,
}
