local icons = require('core.icons')


require('todo-comments').setup({
    -- icon used for the sign, and in search results
    -- can be a hex color, or a named color (see below)
    -- a set of other keywords that all map to this FIX keywords
    -- signs = false, -- configure signs for some keywords individually
  keywords = {
    FIX = { icon = icons.debug, color = 'error', alt={ 'FIXME', 'BUG', 'FIXIT', 'ISSUE', 'fix', 'fixme', 'bug' } },
    TODO = { icon = icons.check, color = 'info' },
    HACK = { icon = icons.flame, color = 'warning' },
    WARN = { icon = icons.warn, color = 'warning', alt = { 'WARNING' } },
    PERF = { icon = icons.perf, alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
    NOTE = { icon = icons.note, color = 'hint', alt = { 'INFO', 'XXX' } },
  },
  colors = {
    error = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
    warning = { 'DiagnosticWarn', 'WarningMsg', '#FBBF24' },
    info = { 'DiagnosticInfo', '#2563EB' },
    hint = { 'DiagnosticHint', '#10B981' },
    default = { 'Identifier', '#7C3AED' },
  },
})
