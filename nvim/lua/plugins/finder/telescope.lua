return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "natecraddock/telescope-zf-native.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "jonarrien/telescope-cmdline.nvim",
    "jmacadie/telescope-hierarchy.nvim",
  },
  event = "VeryLazy",
  keys = require('core.keymaps')["telescope"],
  cmd = "Telescope",
  config = function()
    local icons = require('core.icons')
    local u = require('core.utils')
    local km = require('core.keymaps')

    local actions = require('telescope.actions')
    local mappings = km.telescope_mapping(actions)
    local fb_actions = require("telescope._extensions.file_browser.actions")
    local fb_mappings = km.telescope_file_browser_mapping(fb_actions)

    local opts_cursor = {
      initial_mode = 'normal',
      sorting_strategy = 'ascending',
      layout_strategy = 'cursor',
      results_title = false,
      layout_config = {
        width = 0.99,
        height = 0.4,
      },
    }

    local opts_vertical = {
      initial_mode = 'normal',
      sorting_strategy = 'ascending',
      layout_strategy = 'vertical',
      results_title = false,
      layout_config = {
        width = 0.99,
        height = 0.99,
        prompt_position = 'top',
        mirror = true,
        preview_height = 0.5,
      },
    }

    local opts_flex = {
      layout_strategy = 'flex',
      layout_config = {
        width = 0.99,
        height = 0.99,
      },
    }

    require('telescope').setup({
      defaults = {
        prompt_prefix = icons.search .. ' ',
        selection_caret = icons.folder.arrow_closed .. ' ',
        path_display = { "smart" },
        file_ignore_patterns = {
          '%.git/',
        },
        dynamic_preview_title = true,
        vimgrep_arguments = {
          'rg',
          '-L',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
        },
        mappings = mappings,
      },
      extensions = {
        ["zf-native"] = {
          -- options for sorting file-like items
          file = {
            -- override default telescope file sorter
            enable = true,
            -- highlight matching text in results
            highlight_results = true,
            -- enable zf filename match priority
            match_filename = true,
            -- optional function to define a sort order when the query is empty
            initial_sort = nil,
            -- set to false to enable case sensitive matching
            smart_case = true,
          },

          -- options for sorting all other items
          generic = {
            -- override default telescope generic item sorter
            enable = true,
            -- highlight matching text in results
            highlight_results = true,
            -- disable zf filename match priority
            match_filename = false,
            -- optional function to define a sort order when the query is empty
            initial_sort = nil,
            -- set to false to enable case sensitive matching
            smart_case = true,
          },
        },
        ['file_browser'] = {
          path = vim.loop.cwd(),
          cwd = vim.loop.cwd(),
          cwd_to_path = false,
          grouped = true,
          files = true,
          add_dirs = true,
          depth = 1,
          auto_depth = false,
          select_buffer = false,
          hidden = { file_browser = false, folder_browser = false },
          respect_gitignore = vim.fn.executable "fd" == 1,
          no_ignore = false,
          follow_symlinks = false,
          browse_files = require("telescope._extensions.file_browser.finders").browse_files,
          browse_folders = require("telescope._extensions.file_browser.finders").browse_folders,
          hide_parent_dir = false,
          collapse_dirs = false,
          prompt_path = false,
          quiet = false,
          dir_icon = "",
          dir_icon_hl = "Default",
          -- display_stat = { date = true, size = true, mode = true },
          display_stat = false,
          hijack_netrw = false,
          use_fd = false,
          git_status = true,
          mappings = fb_mappings ,
        },
        ['ui-select'] = { require('telescope.themes').get_dropdown { } }
      },
      pickers = {
        -- ['ui-select'] = u.merge(opts_cursor,
        --   { prompt_title = 'hahah', mappings = mappings }),
        buffers = u.merge(opts_flex,
          {
            prompt_title = 'Search Buffers',
            mappings = u.merge({ n = { ['d'] = actions.delete_buffer, }, }, mappings),
            sort_mru = true,
            preview_title = false,
          }),
        -- lsp_code_actions = u.merge(opts_vertical, { prompt_title = 'Code Actions' }),
        -- lsp_range_code_actions = u.merge(opts_vertical, { prompt_title = 'Code Actions' }),
        lsp_document_diagnostics = u.merge(opts_vertical, { prompt_title = 'Document Diagnostics' }),
        lsp_document_symbols = u.merge(opts_vertical, { prompt_title = 'LSP Doc Symbols' }),
        lsp_implementations = u.merge(opts_vertical, { prompt_title = 'Implementations', }),
        lsp_definitions = u.merge(opts_cursor, { prompt_title = 'Definitions', }),
        lsp_references = u.merge(opts_vertical, { prompt_title = 'References', }),
        find_files = u.merge(opts_flex, { prompt_title = 'Search Project', hidden = true, }),
        file_browser = u.merge(opts_flex, { prompt_title = 'File Browser', hidden = true, }),
        diagnostics = u.merge(opts_flex, { }),
        git_files = u.merge(opts_flex, { prompt_title = 'Search Git Project', hidden = true, }),
        live_grep = u.merge(opts_flex, { prompt_title = 'Live Grep', }),
        grep_string = u.merge(opts_vertical, { prompt_title = 'Grep String', }),
      },
    })

    require("telescope").load_extension("zf-native")
    require('telescope').load_extension('file_browser')
    require('telescope').load_extension('ui-select')
    require('telescope').load_extension('cmdline')
    require("telescope").load_extension("hierarchy")
  end,
}
