
return {
  "sindrets/diffview.nvim",
  init = function()
    require("core.keymaps").load("diffview")
  end,
  cmd = { "DiffviewOpen", "DiffviewToggleFiles", "DiffviewFileHistory" },
  config = function()
    require("diffview").setup({
      view = {
        default = {
          winbar_info = true,
        },
        file_history = {
          winbar_info = true,
        },
      },
    })
  end,
}
