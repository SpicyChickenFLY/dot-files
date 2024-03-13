return {
    "voldikss/vim-floaterm",
    keys = require("core.keymaps")["floaterm"],
    cmd = { "FloatermNew", "FloatermToggle" },
    config = function()
        local g = vim.g
        local title = vim.env.SHELL

        g.floaterm_width = 0.99
        g.floaterm_height = 0.99
        g.floaterm_title = '[' .. title .. ']:($1/$2)'
        g.floaterm_borderchars = '─│─│╭╮╯╰'
        g.floaterm_opener = 'edit', -- 'vsplit'

        vim.cmd(('hi FloatBorder guibg=None')) -- terminal highlights
        vim.cmd('hi! link FloatermBorder FloatBorder')
    end,
}
