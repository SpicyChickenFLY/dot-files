return {
  "xemptuous/sqlua.nvim",
  lazy = true,
  cmd = { "SQLua" },
  keys = require("core.keymaps")["sqlua"],
  config = function() require('sqlua').setup() end
}
