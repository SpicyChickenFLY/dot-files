
return {
  "luukvbaal/statuscol.nvim",
  event = 'BufWinEnter',
  config = function()
    local builtin = require("statuscol.builtin")
    require("statuscol").setup({
      relculright = true,
      segments = {
        -- { text = { "%s" }, click = "v:lua.ScSa" },
        {
          sign = { name = { "Diagnostic" }, maxwidth = 1, auto = true },
          click = "v:lua.ScSa"
        },
        {
          sign = { name = { "Dap*" }, maxwidth = 2, auto = true },
          click = "v:lua.ScSa"
        },
        {
          sign = { name = { ".*" }, maxwidth = 1, colwidth = 1, auto = true, wrap = true },
          click = "v:lua.ScSa"
        },
        { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
        {
          sign = { namespace = { "gitsign" }, maxwidth = 1, colwidth = 1 },
          click = "v:lua.ScSa"
        },
        { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
      },
    })
  end,
}
