
local defaults = {
  ensure_installed = {
    'c',
    'cpp',
    'css',
    'html',
    'go',
    'javascript',
    'jsdoc',
    'json',
    'lua',
    'markdown',
    'python',
    'scss',
    'tsx',
    'typescript',
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
