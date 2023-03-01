local actions = require('telescope.actions')
local icons = require('core.icons')
local u = require('core.utils')

local mappings = {
  n = {
    ['Q'] = actions.smart_add_to_qflist + actions.open_qflist,
    ['q'] = actions.smart_send_to_qflist + actions.open_qflist,
    ['<tab>'] = actions.toggle_selection + actions.move_selection_next,
    ['<s-tab>'] = actions.toggle_selection + actions.move_selection_previous,
    ['v'] = actions.file_vsplit,
    ['s'] = actions.file_split,
    ['<cr>'] = actions.file_edit,
  },
  i = {
    ['<c-h>'] = actions.smart_send_to_qflist + actions.open_qflist,
    ['<c-j>'] = actions.move_selection_next,
    ['<c-k>'] = actions.move_selection_previous,
    ['<c-l>'] = actions.file_edit,
  }
}

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
    file_ignore_patterns = {
      '.git/',
    },
    dynamic_preview_title = true,
    vimgrep_arguments = {
      'rg',
      '--ignore',
      '--hidden',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--trim',
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
    emoji = {
      action = function(emoji)
        -- argument emoji is a table.
        -- {name="", value="", cagegory="", description=""}

        vim.fn.setreg("*", emoji.value)
        print([[Press p or "*p to paste this emoji]] .. emoji.value)

        -- insert emoji when picked
        -- vim.api.nvim_put({ emoji.value }, 'c', false, true)
      end,
    },
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
    lsp_references = u.merge(opts_vertical,
      { prompt_title = 'References', mappings = mappings, }),
    find_files = u.merge(opts_flex,
      { prompt_title = 'Search Project', mappings = mappings, hidden = true, }),
    diagnostics = u.merge(opts_vertical,
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
require('telescope').load_extension('emoji')
