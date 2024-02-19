return { 'NvChad/nvim-colorizer.lua',
event = 'BufWinEnter',
config = function() require('colorizer').setup({}) end,
}
