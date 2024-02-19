return {
  "rmagatti/auto-session",
  keys = {
    {"<leader>ss", ":SessionSave<CR>", "save session" },
    {"<leader>sl", ":SessionRestore<CR>", "load session" },
  },
  cmd = {
    "SessionSave",
    "SessionRestore",
    "SessionDelete",
    "SessionPurgeOrphaned",
    "Autosession",
  },
  config = function () require("auto-session").setup({}) end
}
