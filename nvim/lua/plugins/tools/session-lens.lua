return {
  'rmagatti/session-lens',
  dependenices = {
    "rmagatti/auto-session",
    'nvim-telescope/telescope.nvim'
  },
  cmd = "SearchSession",
  config = function()
    require('session-lens').setup({
      path_display = {'shorten'},
      -- theme = 'catppuccin-latte', -- default is dropdown
      -- theme_conf = { border = false },
      previewer = true
    })
  end
}
