return {
  'nvim-java/nvim-java',
  lazy = true,
  dependencies = {
    'nvim-java/lua-async-await',
    'nvim-java/nvim-java-core',
    'nvim-java/nvim-java-test',
    'nvim-java/nvim-java-dap',
    'MunifTanjim/nui.nvim',
    'neovim/nvim-lspconfig',
    'mfussenegger/nvim-dap',
    'williamboman/mason.nvim',
  },
  init = function() require('java').setup({
    jdk = { auto_install = false },
  }) end,
}
