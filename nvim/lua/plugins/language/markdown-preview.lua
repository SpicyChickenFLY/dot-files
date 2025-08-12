return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  -- build = function() vim.fn["mkdp#util#install"]() end,
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
    vim.cmd([[
      function OpenMarkdownPreview (url)
        execute "silent ! google-chrome-stable --new-window " . a:url
      endfunction
      let g:mkdp_browserfunc = 'OpenMarkdownPreview'
    ]])
  end,
  ft = { "markdown" },
  config = function() require("core.keymaps").markdown_preview() end,
}
