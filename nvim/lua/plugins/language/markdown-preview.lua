return {
  "iamcco/markdown-preview.nvim",
  init = function()
    vim.cmd([[
      function OpenMarkdownPreview (url)
        execute "silent ! firefox --new-window " . a:url
      endfunction
      let g:mkdp_browserfunc = 'OpenMarkdownPreview'
    ]])
  end,
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = function() vim.fn["mkdp#util#install"]() end,
  ft = { "markdown" },
  config = function() require("core.keymaps").markdown_preview() end,
}
