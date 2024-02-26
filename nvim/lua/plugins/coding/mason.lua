return {
  "williamboman/mason.nvim",
	keys = require('core.keymaps').mason,
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
