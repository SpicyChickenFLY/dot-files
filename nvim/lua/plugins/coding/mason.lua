return {
  "williamboman/mason.nvim",
  keys = {
    { "<leader>lm", ":Mason<CR>", desc = "Open Manager(Mason)"},
  },
  cmd = {
    "Mason",
    "MasonUpdate",
    "MasonInstall",
    "MasonUninstall",
    "MasonUninstallAll",
    "MasonLog",
  },
  config = function() require('mason').setup() end,
}
