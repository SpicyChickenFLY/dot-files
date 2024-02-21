return {
  "rmagatti/auto-session",
  keys = require("core.keymaps")["autosession"],
  cmd = {
    "SessionSave",
    "SessionRestore",
    "SessionDelete",
    "SessionPurgeOrphaned",
    "Autosession",
  },
  config = function () require("auto-session").setup({}) end
}
