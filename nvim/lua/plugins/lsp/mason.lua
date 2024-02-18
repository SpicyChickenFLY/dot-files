return {
  "williamboman/mason.nvim",
  init = function() require('core.keymaps').load "mason" end,
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
