-- Active indent guide and indent text objects. When you're browsing
-- code, this highlights the current level of indentation, and animates
-- the highlighting.
return {
"echasnovski/mini.indentscope",
version = false, -- wait till new 0.7.0 release to put it back on semver
event = 'BufWinEnter',
config = function()
    require('mini.indentscope').setup({
    -- Options which control scope computation
    options = {
      -- Type of scope's border: which line(s) with smaller indent to
      -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
      border = 'both',

      -- Whether to use cursor column when computing reference indent.
      -- Useful to see incremental scopes with horizontal cursor movements.
      indent_at_cursor = false,

      -- Whether to first check input line to be a border of adjacent scope.
      -- Use it if you want to place cursor on function header to get scope of
      -- its body.
      try_as_border = true,
    },

    -- Which character to use for drawing scope indicator
    -- symbol = "▏",
    symbol = "│",
    draw = {
      animation = require('mini.indentscope').gen_animation.none()
    },
    mappings = require('core.keymaps').mini_indent_mapping,

  })
end,
init = function()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "help",
      "alpha",
      "dashboard",
      "neo-tree",
      "neotest-summary",
      "Trouble",
      "trouble",
      "lazy",
      "mason",
      "notify",
      "toggleterm",
      "floaterm",
      "lazyterm",
    },
    callback = function()
      vim.b.miniindentscope_disable = true
    end,
  })
end,
}
