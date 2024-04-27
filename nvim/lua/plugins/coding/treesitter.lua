return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
    "windwp/nvim-ts-autotag",
  },
  run = ":TSUpdate",
  event = "BufWinEnter",
  config = function()
    local enable_lang = { "http", "scss", "css", "html", "http", "jsdoc", "javascript", "typescript", "tsx", "vue" }

    local defaults = {
      ensure_installed = {
        "go",
        "java",
        "python",
        "markdown",
        "sql",
        "json",
        "scss",
        "css",
        "html",
        "http",
        "jsdoc",
        "javascript",
        "typescript",
        "tsx",
        "vue",
      },
      highlight = {
        enable = true,
        disable = function(lang, buf) -- omit lang
          for _, parser in ipairs(enable_lang) do
            if lang == parser then
              local max_filesize = 100 * 1024 -- 100KB
              local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                return true
              end
              return false
            end
          end
          return true
        end,
        use_languagetree = true,
        additional_vim_regex_highlighting = false,
      },
      autotag = {
        enable = true,
        disable = function(_, buf) -- omit lang
          for _, parser in ipairs(enable_lang) do
            if lang == parser then
              local max_filesize = 100 * 1024 -- 100KB
              local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                return true
              end
              return false
            end
          end
          return true
        end,
      },
      context_commentstring = {
        enable = true,
        disable = function(lang, buf) -- omit lang
          for _, parser in ipairs(enable_lang) do
            if lang == parser then
              local max_filesize = 100 * 1024 -- 100KB
              local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                return true
              end
              return false
            end
          end
          return true
        end,
        enable_autocmd = false,
      },
    }

    require("nvim-treesitter.configs").setup(defaults)
  end,
}
