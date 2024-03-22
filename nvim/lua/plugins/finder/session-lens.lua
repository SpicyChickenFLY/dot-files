return {
  'rmagatti/session-lens',
  dependenices = {
    "rmagatti/auto-session",
    'nvim-telescope/telescope.nvim'
  },
  keys = require('core.keymaps').sessionlens,
  cmd = "SearchSession",
  config = function()
    require('session-lens').setup({
      -- path_display = {'shorten'},
      path_display = {},
      previewer = false
    })
    require('telescope').load_extension('session-lens')
  end
}
