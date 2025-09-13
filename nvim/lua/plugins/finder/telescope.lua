return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    -- {
    --   "nvim-telescope/telescope-fzf-native.nvim",
    --   build =
    --   "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5 && cmake --build build --config Release && cmake --install build --prefix build",
    -- },
    -- "natecraddock/telescope-zf-native.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  event = "VeryLazy",
  keys = require('core.keymaps')["telescope"],
  cmd = "Telescope",
  config = function()
    local actions = require('telescope.actions')
    local icons = require('core.icons')
    local u = require('core.utils')

    local mappings = require('core.keymaps').telescope_mapping(actions)

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
        selection_caret = icons.folder.arrow_closed,
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
        -- fzf = {
        --   fuzzy = true,                   -- false will only do exact matching
        --   override_generic_sorter = true, -- override the generic sorter
        --   override_file_sorter = true,    -- override the file sorter
        --   case_mode = 'smart_case',       -- or "ignore_case" or "respect_case"
        --   -- the default case_mode is "smart_case"
        -- },
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
        ['ui-select'] = {
          require('telescope.themes').get_dropdown { }
        }
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
        lsp_implementations = u.merge(opts_cursor, { prompt_title = 'Implementations', }),
        lsp_definitions = u.merge(opts_cursor, { prompt_title = 'Definitions', }),
        lsp_references = u.merge(opts_flex, { prompt_title = 'References', }),
        find_files = u.merge(opts_flex, { prompt_title = 'Search Project', hidden = true, }),
        diagnostics = u.merge(opts_flex, { }),
        git_files = u.merge(opts_flex, { prompt_title = 'Search Git Project', hidden = true, }),
        live_grep = u.merge(opts_flex, { prompt_title = 'Live Grep', }),
        grep_string = u.merge(opts_vertical, { prompt_title = 'Grep String', }),
      },
    })

    -- require('telescope').load_extension('fzf')
    -- require("telescope").load_extension("zf-native")
    require('telescope').load_extension('ui-select')
  end,
}
