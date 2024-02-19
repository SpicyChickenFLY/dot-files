return {
  "iamcco/markdown-preview.nvim",
  init = function()
    vim.cmd([[
    function OpenMarkdownPreview (url)
      execute "silent ! firefox --new-window --app=" .a:url
    endfunction
    ]])
    vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'
  end,
  cmd = {
    "MarkdownPreviewToggle",
    "MarkdownPreview",
    "MarkdownPreviewStop"
  },
  ft = { "markdown" },
  build = function() vim.fn["mkdp#util#install"]() end,
}
