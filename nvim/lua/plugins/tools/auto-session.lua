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
  config = function () require("auto-session").setup({
    session_lens = {
      path_display = {}, -- {'shorten'},
      bypass_session_save_file_types = { 'netrw' },
      load_on_setup = true,
      theme_conf = { border = true },
      previewer = false,
      mappings = require('core.keymaps').autosession_mapping(),
    }
  }) end
}
