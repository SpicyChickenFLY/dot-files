local icons = require("core.icons")

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


-- set up args
local args = {
  respect_buf_cwd = true,
  diagnostics = {
    enable = true,
    icons = {
      hint = icons.hint,
      info = icons.info,
      warning = icons.warn,
      error = icons.error,
    },
  },
  ignore_ft_on_setup = {
    "startify",
    "dashboard",
    "alpha",
  },
  update_focused_file = {
    enable = true,
  },
  view = {
    width = 40,
    number = false,
    relativenumber = false,
    float = {
      enable = false,
      quit_on_focus_loss = true,
      open_win_config = { relative = "win", row = 3, col = 3, width = 30, height = 30 },
    },
    mappings = {
      list = {
        { key = { "<CR>", "l", "<2-LeftMouse>" }, action = "edit" },
        -- { key = "<C-S-e>", action = "edit_in_place" },
        { key = "O", action = "edit_no_picker" },
        { key = { "<C-]>", "<2-RightMouse>" }, action = "cd" },
        { key = "<C-v>", action = "vsplit" },
        { key = "<C-x>", action = "split" },
        { key = "<C-t>", action = "tabnew" },
        { key = "K", action = "prev_sibling" },
        { key = "J", action = "next_sibling" },
        { key = "h", action = "parent_node" },
        { key = "<BS>", action = "close_node" },
        { key = "<Tab>", action = "preview" },
        -- { key = "",                              action = "first_sibling" },
        -- { key = "",                              action = "last_sibling" },
        { key = "I", action = "toggle_git_ignored" },
        { key = "<C-h>", action = "toggle_dotfiles" },
        { key = "U", action = "toggle_custom" },
        { key = "R", action = "refresh" },
        { key = "a", action = "create" },
        { key = "d", action = "remove" },
        { key = "D", action = "trash" },
        { key = "r", action = "rename" },
        { key = "<C-r>", action = "full_rename" },
        { key = "x", action = "cut" },
        { key = "c", action = "copy" },
        { key = "p", action = "paste" },
        { key = "y", action = "copy_name" },
        { key = "Y", action = "copy_path" },
        { key = "gy", action = "copy_absolute_path" },
        { key = "[e", action = "prev_diag_item" },
        { key = "[c", action = "prev_git_item" },
        { key = "]e", action = "next_diag_item" },
        { key = "]c", action = "next_git_item" },
        { key = "H", action = "dir_up" },
        { key = "s", action = "system_open" },
        { key = "f", action = "live_filter" },
        { key = "F", action = "clear_live_filter" },
        { key = { "<C-E>", "<esc>" }, action = "close" },
        { key = "W", action = "collapse_all" },
        { key = "E", action = "expand_all" },
        { key = "S", action = "search_node" },
        { key = ".", action = "run_file_command" },
        { key = "<C-k>", action = "toggle_file_info" },
        { key = "g?", action = "toggle_help" },
        { key = "m", action = "toggle_mark" },
        { key = "bmv", action = "bulk_move" },
      },
    },
  },
  git = {
    enable = false,
    ignore = true,
  },
  renderer = {
    highlight_git = true,
    special_files = {},
    icons = {
      glyphs = {
        default = "",
        symlink = icons.symlink,
        git = icons.git,
        folder = icons.folder,
      },
    },
    group_empty = true,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    }
  }
}

-- Autoclose nvim is nvim-tree is only buffer open
local augroup_name = "MyNvimTree"
local group = vim.api.nvim_create_augroup(augroup_name, { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  command = [[if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]],
  group = group,
  nested = true,
})

require("nvim-tree").setup(args)

