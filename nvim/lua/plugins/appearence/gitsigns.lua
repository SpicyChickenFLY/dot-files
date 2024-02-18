
return {
  'lewis6991/gitsigns.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = 'BufWinEnter',
  config = function()
    require('gitsigns').setup({
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        map('n', ']c', gs.next_hunk, 'Next hunk')
        map('n', '[c', gs.prev_hunk, 'Prev hunk')

        map('n', '<leader>gs', gs.stage_hunk, 'Stage hunk')
        map('n', '<leader>gr', gs.reset_hunk, 'Reset hunk')
        map('n', '<leader>gp', gs.preview_hunk, 'Preview hunk')
        map('n', '<leader>gb', function() gs.blame_line{full=true} end, 'Blame line')

        -- NOTE: dont need buffer operation
        -- map('n', '<leader>gS', gs.stage_buffer)
        -- map('n', '<leader>gu', gs.undo_stage_hunk)
        -- map('n', '<leader>gR', gs.reset_buffer)
        -- NOTE: will be replaced by diffview.nvim
        -- map('n', '<leader>gd', gs.diffthis)
        -- map('n', '<leader>gD', function() gs.diffthis('~') end)
        -- map('n', '<leader>gd', gs.toggle_deleted)

        map('v', '<leader>gs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, 'Stage hunk')
        map('v', '<leader>gr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, 'Reset hunk')

        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end,
      signs = {
        add          = { hl = 'GitSignsAdd'   , text = '┃'},
        change       = { hl = 'GitSignsChange', text = '┋'},
        delete       = { hl = 'GitSignsDelete', text = ''},
        topdelete    = { hl = 'GitSignsDelete', text = ''},
        changedelete = { hl = 'GitSignsChange', text = '┋'},
        untracked    = { hl = 'GitSignsAdd'   , text = '┃'},
      },
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = false,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = '<author>, <author_time:%R>',
      current_line_blame_formatter_opts = {
        relative_time = true,
      },
      sign_priority = 0,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000,
      preview_config = {
        -- Options passed to nvim_open_win
        border = 'rounded',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1,
      },
      yadm = {
        enable = false,
      },
    })
  end,
}
