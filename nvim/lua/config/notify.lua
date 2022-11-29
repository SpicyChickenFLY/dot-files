local icons = require('core.icons')

require('notify').setup({
  icons = {
    ERROR = icons.error,
    WARN = icons.warn,
    INFO = icons.info,
    DEBUG = icons.debug,
    TRACE = icons.trace,
  },
  stages = 'slide',
})

vim.notify = require('notify')

