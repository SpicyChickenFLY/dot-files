return {
    "voldikss/vim-floaterm",
    init = function()
        require("core.keymaps").load("floaterm")
    end,
    cmd = { "FloatermNew", "FloatermToggle" },
    config = function()
        local g = vim.g
        local title = vim.env.SHELL

        g.floaterm_width = 0.9
        g.floaterm_height = 0.9
        g.floaterm_title = '[' .. title .. ']:($1/$2)'
        g.floaterm_borderchars = '─│─│╭╮╯╰'
        g.floaterm_opener = 'vsplit'

        vim.cmd(('hi FloatBorder guibg=None')) -- terminal highlights
        vim.cmd('hi! link FloatermBorder FloatBorder')
    end,
}
