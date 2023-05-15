
local defaults = {
  ensure_installed = {
    'c', 'cpp',
    'go',
    'jsdoc',
    'json',
    'lua',
    'markdown',
    'python',
    'tsx',
    'scss', 'css', 'html', 'http', 'javascript', 'typescript',
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  rainbow = {
    enable = true,
    query = 'rainbow-parens',
    strategy = require('ts-rainbow').strategy.global,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = false },
  },
}

require('nvim-treesitter.configs').setup(defaults)
