return {
  "L3MON4D3/LuaSnip",
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    local ls = require("luasnip")
    -- some shorthands...
    -- local s = ls.snippet
    -- local sn = ls.snippet_node
    -- local t = ls.text_node
    -- local i = ls.insert_node
    -- local f = ls.function_node
    -- local c = ls.choice_node
    -- local d = ls.dynamic_node

    -- Every unspecified option will be set to the default.
    ls.config.set_config({
      history = true,
      update_events = "TextChanged,TextChangedI",
      delete_check_events = "TextChanged",
      enable_autosnippets = true,
    })

    ls.snippets = {
      all = {},
      html = {},
    }

    -- enable html snippets in javascript/javascript(REACT)
    ls.snippets.javascript = ls.snippets.html
    ls.snippets.javascriptreact = ls.snippets.html
    ls.snippets.typescriptreact = ls.snippets.html

    -- You can also use lazy loading so you only get in memory snippets of languages you use
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
