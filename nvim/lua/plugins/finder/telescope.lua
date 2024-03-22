return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    },
    "nvim-telescope/telescope-ui-select.nvim",
  },
  event = "VeryLazy",
  keys = require('core.keymaps')["telescope"],
  cmd = "Telescope",
  config = function()
    local actions = require('telescope.actions')
    local icons = require('core.icons')
    local u = require('core.utils')

    local mappings = { n = { }, i = { } }
    local opts_cursor = {
      initial_mode = 'normal',
      sorting_strategy = 'ascending',
      layout_strategy = 'cursor',
      results_title = false,
      layout_config = {
        width = 0.5,
        height = 0.4,
      },
    }

    local opts_vertical = {
      initial_mode = 'normal',
      sorting_strategy = 'ascending',
      layout_strategy = 'vertical',
      results_title = false,
      layout_config = {
        width = 0.3,
        height = 0.5,
        prompt_position = 'top',
        mirror = true,
      },
    }

    local opts_flex = {
      layout_strategy = 'flex',
      layout_config = {
        width = 0.7,
        height = 0.7,
      },
    }

    require('telescope').setup({
      defaults = {
        prompt_prefix = icons.search .. ' ',
        selection_caret = icons.folder.arrow_closed,
        path_display={"smart"},
        file_ignore_patterns = {
          '.git/',
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
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
        ['ui-select'] = {
          require('telescope.themes').get_dropdown {

          }
        }
      },
      pickers = {
        buffers = u.merge(opts_flex,
          { prompt_title = 'Search Buffers',
            mappings = u.merge({ n = { ['d'] = actions.delete_buffer, }, }, mappings),
            sort_mru = true,
            preview_title = false,
        }),
        lsp_code_actions = u.merge(opts_cursor,
          { prompt_title = 'Code Actions', }),
        lsp_range_code_actions = u.merge(opts_vertical,
          { prompt_title = 'Code Actions', }),
        lsp_document_diagnostics = u.merge(opts_vertical,
          { prompt_title = 'Document Diagnostics', mappings = mappings, }),
        lsp_implementations = u.merge(opts_cursor,
          { prompt_title = 'Implementations', mappings = mappings, }),
        lsp_definitions = u.merge(opts_cursor,
          { prompt_title = 'Definitions', mappings = mappings, }),
        lsp_references = u.merge(opts_flex,
          { prompt_title = 'References', mappings = mappings, }),
        find_files = u.merge(opts_flex,
          { prompt_title = 'Search Project', mappings = mappings, hidden = true, }),
        diagnostics = u.merge(opts_flex,
          { mappings = mappings, }),
        git_files = u.merge(opts_flex,
          { prompt_title = 'Search Git Project', mappings = mappings, hidden = true, }),
        live_grep = u.merge(opts_flex,
          { prompt_title = 'Live Grep', mappings = mappings, }),
        grep_string = u.merge(opts_vertical,
          { prompt_title = 'Grep String', mappings = mappings, }),
      },
    })

    require('telescope').load_extension('fzf')
    require('telescope').load_extension('ui-select')
  end,
}
