return {
  'folke/todo-comments.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  event = 'BufWinEnter',
  config = function()
    local icons = require('core.icons')
    require('todo-comments').setup({
      -- icon used for the sign, and in search results
      -- can be a hex color, or a named color (see below)
      -- a set of other keywords that all map to this FIX keywords
      signs = false, -- configure signs for some keywords individually
      keywords = {
        FIX = { icon = icons.debug, color = 'error', alt={ 'FIXME', 'BUG', 'FIXIT', 'ISSUE', 'fix', 'fixme', 'bug' } },
        TODO = { icon = icons.check, color = 'info', alt={ 'todo' } },
        HACK = { icon = icons.flame, color = 'error' },
        WARN = { icon = icons.warn, color = 'warning', alt = { 'WARNING' } },
        PERF = { icon = icons.perf, alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
        NOTE = { icon = icons.note, color = 'hint', alt = { 'INFO', 'XXX' } },
      },
      colors = {
        error = { 'DiagnosticError' },
        warning = { 'DiagnosticWarn' },
        info = { 'DiagnosticInfo' },
        hint = { 'DiagnosticHint' },
        default = { 'Identifier' },
      },
    })
  end,
}

