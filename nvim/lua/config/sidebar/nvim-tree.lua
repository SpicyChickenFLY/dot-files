local icons = require("core.icons")

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- vim.g.nvim_tree_group_empty = 1

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  local map = vim.keymap.set

  -- node navigation
  map('n', 'h', api.node.navigate.parent, opts('Parent Directory'))
  map('n', 'J', api.node.navigate.sibling.next, opts('Next Sibling'))
  map('n', 'K', api.node.navigate.sibling.prev, opts('Previous Sibling'))
  map('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
  map('n', ']c', api.node.navigate.git.next, opts('Next Git'))
  map('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
  map('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
  -- filter
  map('n', 'f', api.live_filter.start, opts('Filter'))
  map('n', 'F', api.live_filter.clear, opts('Clean Filter'))
  -- node operation
  map('n', '<CR>', api.node.open.edit, opts('Open'))
  map('n', 'l', api.node.open.edit, opts('Open'))
  map('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
  map('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
  map('n', 's', api.node.run.system, opts('Run System'))
  map('n', '.', api.node.run.cmd, opts('Run Command'))
  map('n', 'gh', api.node.show_info_popup, opts('Info'))
  -- tree operation
  map('n', 'q', api.tree.close, opts('Close'))
  map('n', 'zm', api.tree.collapse_all, opts('Collapse'))
  map('n', 'zr', api.tree.expand_all, opts('Expand All'))
  map('n', 'H', api.tree.change_root_to_parent, opts('Up'))
  map('n', 'R', api.tree.reload, opts('Refresh'))
  map('n', 'g?', api.tree.toggle_help, opts('Help'))
  -- toggle display
  map('n', 'tg', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
  map('n', 'th', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
  map('n', 'tf', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
  map('n', 'tm', api.marks.toggle, opts('Toggle Bookmark'))
  -- file operation
  map('n', 'a', api.fs.create, opts('Create'))
  map('n', 'd', api.fs.remove, opts('Delete'))
  map('n', 'c', api.fs.copy.node, opts('Copy'))
  map('n', 'x', api.fs.cut, opts('Cut'))
  map('n', 'p', api.fs.paste, opts('Paste'))
  map('n', 'r', api.fs.rename, opts('Rename'))
  map('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
  map('n', 'y', api.fs.copy.filename, opts('Copy Name'))
  map('n', 'gy', api.fs.copy.relative_path, opts('Copy Relative Path'))
  map('n', 'gY', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
end

require("nvim-tree").setup { -- BEGIN_DEFAULT_OPTS
  auto_reload_on_write = true,
  disable_netrw = true,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  sort_by = "name",
  root_dirs = {},
  prefer_startup_root = false,
  sync_root_with_cwd = false,
  reload_on_bufenter = false,
  respect_buf_cwd = false,
  on_attach = on_attach,
  remove_keymaps = false,
  select_prompts = false,
  view = {
    centralize_selection = false,
    cursorline = true,
    debounce_delay = 15,
    width = 30,
    hide_root_folder = false,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
    },
    float = {
      enable = false,
      quit_on_focus_loss = true,
      open_win_config = {
        relative = "editor",
        border = "rounded",
        width = 30,
        height = 30,
        row = 1,
        col = 1,
      },
    },
  },
  renderer = {
    add_trailing = false,
    group_empty = true,
    highlight_git = true,
    full_name = false,
    highlight_opened_files = "none",
    highlight_modified = "none",
    root_folder_label = ":~:s?$?/..?",
    indent_width = 2,
    indent_markers = {
      enable = true,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "after",
      modified_placement = "after",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
        modified = false,
      },
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "",
        modified = "●",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
    symlink_destination = true,
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = false,
    update_root = false,
    ignore_list = {},
  },
  system_open = {
    cmd = "",
    args = {},
  },
  diagnostics = {
    enable = true,
    show_on_dirs = false,
    show_on_open_dirs = true,
    debounce_delay = 50,
    severity = {
      min = vim.diagnostic.severity.HINT,
      max = vim.diagnostic.severity.ERROR,
    },
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = false,
    git_clean = false,
    no_buffer = false,
    custom = {},
    exclude = {},
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 50,
    ignore_dirs = {},
  },
  git = {
    enable = true,
    ignore = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
    timeout = 400,
  },
  modified = {
    enable = false,
    show_on_dirs = true,
    show_on_open_dirs = true,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    expand_all = {
      max_folder_discovery = 300,
      exclude = {},
    },
    file_popup = {
      open_win_config = {
        col = 1,
        row = 1,
        relative = "cursor",
        border = "shadow",
        style = "minimal",
      },
    },
    open_file = {
      quit_on_open = true,
      resize_window = true,
      window_picker = {
        enable = true,
        picker = "default",
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
    remove_file = {
      close_window = true,
    },
  },
  trash = {
    cmd = "gio trash",
  },
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = true,
  },
  tab = {
    sync = {
      open = false,
      close = false,
      ignore = {},
    },
  },
  notify = {
    threshold = vim.log.levels.INFO,
  },
  ui = {
    confirm = {
      remove = true,
      trash = true,
    },
  },
  experimental = {
    git = {
      async = true,
    },
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      dev = false,
      diagnostics = false,
      git = false,
      profile = false,
      watcher = false,
    },
  },
} -- END_DEFAULT_OPTS

