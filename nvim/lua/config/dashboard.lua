local icons = require('core.icons')
local db = require('dashboard')

db.custom_header = {
  '',
  '',
  '',
  '',
  '',
  '',
  ' ██████╗ ██████╗ ███████╗███╗   ███╗██╗ ██████╗███╗   ██╗██╗   ██╗██╗███╗   ███╗',
  '██╔════╝██╔═══██╗██╔════╝████╗ ████║██║██╔════╝████╗  ██║██║   ██║██║████╗ ████║',
  '██║     ██║   ██║███████╗██╔████╔██║██║██║     ██╔██╗ ██║██║   ██║██║██╔████╔██║',
  '██║     ██║   ██║╚════██║██║╚██╔╝██║██║██║     ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║',
  '╚██████╗╚██████╔╝███████║██║ ╚═╝ ██║██║╚██████╗██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║',
  ' ╚═════╝ ╚═════╝ ╚══════╝╚═╝     ╚═╝╚═╝ ╚═════╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝',
  '',
  '',
  '',
}

db.default_executive = 'telescope'

db.hide_winbar = true
db.hide_tabline = true
db.hide_statusline = true

db.session_directory = vim.fn.stdpath('data') .. '/sessions'

db.center_pad = 2

db.custom_center = {
  { icon = icons.file1, desc = ' File Manager', shortcut = ' <C-E>', command = 'NvimTreeToggle' },
  { icon = icons.file1, desc = ' Grep String', shortcut = ' <leader> f s' },
  { icon = icons.file1, desc = ' Find File', shortcut = ' <leader> f f' },
  { icon = icons.clock, desc = ' Load Session', shortcut = ' <leader>sl'}
}

db.custom_footer = { '折腾到死' }
