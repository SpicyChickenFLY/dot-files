return {
  "rest-nvim/rest.nvim",
  dependencies = { { "nvim-lua/plenary.nvim" } },
  -- cmd = { "RestNvim", "RestNvimPreview", "RestNvimLast"},
  keys = require("core.keymaps")["rest"],
  config = function()
    require("rest-nvim").setup({
      --- Get the same options from Packer setup
    })
  end
}
