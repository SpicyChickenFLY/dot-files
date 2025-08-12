return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
  },
  event = "BufWinEnter",
  cmd = {
    "LspInstall",
    "LspUninstall",
  },
  config = function() require('mason-lspconfig').setup({
    automatic_enable = {
        exclude = {
            "jdtls"
        }
    }
  }) end,
}
