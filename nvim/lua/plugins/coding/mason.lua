return {
  "mason-org/mason.nvim",
	keys = require('core.keymaps').mason,
  cmd = {
    "Mason",
    "MasonUpdate",
    "MasonInstall",
    "MasonUninstall",
    "MasonUninstallAll",
    "MasonLog",
  },
  config = function() require('mason').setup({
    registries = {
      'github:nvim-java/mason-registry',
      'github:mason-org/mason-registry',
    },
  }) end,
}
