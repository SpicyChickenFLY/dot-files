local map = require("core.utils").map

map("n", "<ESC>", ":nohl<CR>")
-- move around windows & split window
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
-- map("n", "<C-H>", ":vsp<CR>:bprevious<CR><C-w>h")
-- map("n", "<C-J>", ":sp<CR>:bprevious<CR><C-w>j")
-- map("n", "<C-K>", ":sp<CR>:bprevious<CR><C-w>k")
-- map("n", "<C-L>", ":vsp<CR>:bprevious<CR><C-w>l")
-- resize window
map("n", "-", ":resize -2<CR>")
map("n", "=", ":resize +2<CR>")
map("n", "_", ":vertical resize -5<CR>")
map("n", "+", ":vertical resize +5<CR>")
-- quick exit insert mode
map("i", "jj", "<ESC>")
map("i", "jk", "<ESC>:w<CR>")
map("i", "<C-v>", "<ESC>pi")
-- Emacs
map("i", "<C-a>", "<Home>")
map("i", "<C-e>", "<End>")
map("i", "<C-b>", "<Left>")
map("i", "<C-f>", "<Right>")
map("i", "<C-n>", "<Down>")
map("i", "<C-p>", "<Up>")
-- Terminal
map("n", "<C-\\>", ":FloatermToggle<CR>")
map("t", "<C-\\>", [[<C-\><C-n>:FloatermToggle<CR>]])

-- NOTE: command <f> mapping
local hop = require('hop')
local directions = require('hop.hint').HintDirection
map('n', 'f', function() hop.hint_char1(
  { direction = directions.AFTER_CURSOR, current_line_only = true }) end)
map('n', 'F', function() hop.hint_char1(
  { direction = directions.BEFORE_CURSOR, current_line_only = true }) end)
map('n', 't', function() hop.hint_char1(
  { direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }) end)
map('n', 'T', function() hop.hint_char1(
  { direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }) end)

-- NOTE: command <z> mapping
map("n", "zR", ":lua require'ufo'.openAllFolds()<CR>", { desc = "open all folds" })
map("n", "zM", ":lua require'ufo'.closeAllFolds()<CR>", { desc = "close all folds" })
map("n", "zr", ":lua require'ufo'.openFoldsExceptKinds()<CR>", { desc = "open next fold level"})
map("n", "zm", ":lua require'ufo'.closeFoldsWith()<CR>", { desc = "close next fold level"})
map("n", "z1", ":lua require'ufo'.closeFoldsWith(1)<CR>", { desc = "close fold level 1" })
map("n", "z2", ":lua require'ufo'.closeFoldsWith(2)<CR>", { desc = "close fold level 2" })
map("n", "z3", ":lua require'ufo'.closeFoldsWith(3)<CR>", { desc = "close fold level 3" })
map("n", "z4", ":lua require'ufo'.closeFoldsWith(4)<CR>", { desc = "close fold level 4" })

-- NOTE: command <g> mapping
map("n", "gd", vim.lsp.buf.definition, { desc = "goto func def" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "goto func def" })
map("n", "gh", vim.lsp.buf.hover, { desc = "show hover info" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "goto if impl" })
map("n", "gr", vim.lsp.buf.references, { desc = "goto refer" })
map("n", "gs", vim.lsp.buf.document_symbol, { desc = "show document symbol " })
map("n", "gt", vim.lsp.buf.type_definition, { desc = "goto type def" })

map("n", "<F5>", ":lua require'dap'.continue()<CR>")
map("n", "<S-F5>", ":lua require'dap'.run_to_cursor()<CR>")
map("n", "<F9>", ":lua require'dap'.toggle_breakpoint()<CR>")
map("n", "<S-F9>", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
map("n", "<S-F8>", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
map("n", "<F10>", ":lua require'dap'.step_over()<CR>")
map("n", "<F11>", ":lua require'dap'.step_into()<CR>")
map("n", "<S-F11>", ":lua require'dap'.step_out()<CR>")
-- map("n", "",  ":lua require'dap'.pause()<cr>" )
map("n", "<F12>", ":lua require'dap'.run_last()<CR>")
map("n", "<S-F12>", ":lua require'dap'.terminate()<CR>")
-- map("n", "",     ":lua require'dap'.repl.toggle()<CR>")

-- NOTE: command goto with [ and ]
map("n", "[d", function() vim.diagnostic.goto_prev() end, { desc = "goto prev" })
map("n", "]d", function() vim.diagnostic.goto_next() end, { desc = "goto_next" })
map("n", "[c", ":lua require 'gitsigns'.prev_hunk({navigation_message=false})<cr>", { desc = "Prev Hunk" })
map("n", "]c", ":lua require 'gitsigns'.next_hunk({navigation_message=false})<cr>", { desc = "Next Hunk" })
map("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" })
map("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo comment" })

-- NOTE: leader mapping
local leader_mapping = {
  ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle current line" },
  b = { name = "Buffer",
    n = { ":BufferLineCycleNext<CR>", "prev buffer" },
    p = { ":BufferLineCyclePrev<CR>", "next buffer" },
    s = { name = "Sort Buffers",
      e = { ":BufferLineSortByExtension<CR>", "By Extenstion"},
      d = { ":BufferLineSortByDirectory<CR>", "By Directory"},
    },
  },
  e = { name = "File Explorer",
    e = { ":NvimTreeFocus<CR>", "Open" },
    f = { ":NvimTreeFindFile<CR>", "Find File" },
    r = { ":Ranger<CR>", "Open" },
  },
  f = { name = "Find",
    e = { ":Telescope emoji<cr>", "Checkout branch" },
    f = { ":Telescope find_files<cr>", "Find File" },
    h = { ":Telescope help_tags<cr>", "Find Help" },
    H = { ":Telescope highlights<cr>", "Find highlight groups" },
    i = { ":IconPickerNormal nerd_font_v3 alt_font emoji symbols html_colors<cr>", "Find Icon" },
    M = { ":Telescope man_pages<cr>", "Man Pages" },
    l = { ":Telescope live_grep<cr>", "Text" },
    k = { ":Telescope keymaps<cr>", "Keymaps" },
    C = { ":Telescope commands<cr>", "Commands" },
    p = { ":lua require('telescope.builtin').colorscheme({enable_preview=true})<cr>",
      "Colorscheme with Preview", },
  },
  g = { name = "Git",
    b = { ":lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    d = { ":DiffviewOpen<cr>", "Git Diff" },
    h = { ":DiffviewFileHistory %<cr>", "Show current file history" },
    g = { ":Telescope git_status<cr>", "Open changed file" },
    l = { ":Lazygit<cr>", "Lazygit" },
    s = { ":lua require 'gitsigns'.stage_hunk()<cr>", "Stage" },
    r = { ":lua require 'gitsigns'.reset_hunk()<cr>", "Reset" },
    p = { ":lua require 'gitsigns'.preview_hunk()<cr>", "Preview" },
  },
  j = { ":BufferLineCyclePrev<CR>", "next buffer" },
  J = { ":tabprevious<CR>", "next buffer" },
  k = { ":BufferLineCycleNext<CR>", "prev buffer" },
  K = { ":tabnext<CR>", "prev buffer" },
  l = { name = "LSP",
    r = { vim.lsp.buf.rename, "rename var/func/class" },
    s = { vim.lsp.buf.signature_help, "signature help" },
    a = { vim.lsp.buf.code_action, "action for err/warn" },
    f = { ":Format<CR>", "format file" },
    l = { ":LspLog<CR>", "open LSP log" },
    i = { ":LspInfo<CR>", "show LSP info" },
    R = { ":LspRestart<CR>", "restart LSP" },
    m = { ":Mason<CR>", "open Mason" },
    w = { name = "workspace",
      a = { vim.lsp.buf.add_workspace_folder, "add" },
      r = { vim.lsp.buf.remove_workspace_folder, "remove" },
      l = {
        function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end,
        "list workspaces",
      },
    },
    d = { name = "diagnostic",
      d = { ":lua require 'lsp_lines'.toggle()<cr>", "toggle virtual text"},
      x = { ":TroubleToggle<cr>", "Open" },
      w = { ":TroubleToggle workspace_diagnostics<cr>", "workspace" },
      D = { ":TroubleToggle document_diagnostics<cr>", "document" },
      q = { ":TroubleToggle quickfix<cr>", "quickfix" },
      l = { ":TroubleToggle loclist<cr>", "loclist" },
    },
  },
  p = { name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    r = { "<cmd>lua require('lvim.plugin-loader').recompile()<cr>", "Re-compile" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
  q = { ":bdelete<CR>", "delete buffer" },
  r = { name = "Replacer",
    r = { '<cmd>lua require("spectre").open()<cr>', "open" },
    w = { '<cmd>lua require("spectre").open_visual({select_word=true})<cr>', "open with current word" },
    f = { 'viw:lua require("spectre").open_file_search()<cr>', "open file search" },
  },
  s = { name = "Session",
    s = { ":SessionSave<cr>", "save session" },
    l = { ":SessionRestore<cr>", "load session" },
  },
  t = { name = "Todo",
    t = { ":TodoTrouble<cr>", "Open" },
    q = { ":TodoQuickFix<cr>", "quickfix" },
    l = { ":TodoLocList<cr>", "loclist" },
    f = { ":TodoTelescope<cr>", "find in telescope" },
  },
  u = { name = "Utils Tools",
    d = { name = "Debug Tool",
      b = { ":lua require'dap'.step_back()<cr>", "step back" },
      B = { ":lua require'dap'.toggle_breakpoint()<cr>", "toggle breakpoint" },
      c = { ":lua require'dap'.continue()<cr>", "continue" },
      r = { ":lua require'dap'.run_to_cursor()<cr>", "run to cursor" },
      d = { ":lua require'dap'.disconnect()<cr>", "disconnect" },
      g = { ":lua require'dap'.session()<cr>", "get session" },
      i = { ":lua require'dap'.step_into()<cr>", "step into" },
      l = { ":lua require'dap'.repl.toggle()<cr>", "toggle repl" },
      o = { ":lua require'dap'.step_over()<cr>", "step over" },
      u = { ":lua require'dap'.step_out()<cr>", "step out" },
      p = { ":lua require'dap'.pause()<cr>", "pause" },
      s = { ":lua require'dap'.continue()<cr>", "start" },
      q = { ":lua require'dap'.close()<cr>", "quit" },
      U = { ":lua require'dapui'.toggle()<cr>", "Toggle UI" },
    },
    h = { name = "Http Tool",
      h = { '<Plug>RestNvim', 'run the request under the cursor' },
      p = { '<Plug>RestNvimPreview', 'preview the request cURL command' },
      l = { '<Plug>RestNvimLast', 're-run the last request' },
    },
    x = { name = "Database Tool",
      x = { "<Cmd>DBUIToggle<Cr>", "Toggle UI" },
      f = { "<Cmd>DBUIFindBuffer<Cr>", "Find buffer" },
      q = { "<Cmd>DBUILastQueryInfo<Cr>", "Last query info" },
      r = { "<Cmd>DBUIRenameBuffer<Cr>", "Rename buffer"},
    },
  },
  w = { ":w<cr>", "Save current buffer" },
  W = { ":w !sudo tee %<cr>", "Save current buffer with super priv" },
}

local visual_leader_mapping = {
  g = { name= "Git",
    s = { ":lua require 'gitsigns'.stage_hunk()<cr>", "Stage" },
    r = { ":lua require 'gitsigns'.reset_hunk()<cr>", "Reset" },
  }
}

local wk = require("which-key")
wk.register(leader_mapping, { prefix = "<leader>" })
wk.register(visual_leader_mapping, { prefix = "<leader>", mode="v" })

local M = {}

function M.nvim_tree_keymap(bufnr)
  local _api = require('nvim-tree.api')

  local function _opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  local _map = vim.keymap.set
  _map('n', 'h', _api.node.navigate.parent, _opts('Parent Directory'))
  _map('n', 'J', _api.node.navigate.sibling.next, _opts('Next Sibling'))
  _map('n', 'K', _api.node.navigate.sibling.prev, _opts('Previous Sibling'))
  _map('n', ']e', _api.node.navigate.diagnostics.next, _opts('Next Diagnostic'))
  _map('n', ']c', _api.node.navigate.git.next, _opts('Next Git'))
  _map('n', '[e', _api.node.navigate.diagnostics.prev, _opts('Prev Diagnostic'))
  _map('n', '[c', _api.node.navigate.git.prev, _opts('Prev Git'))
  -- filter
  _map('n', 'f', _api.live_filter.start, _opts('Filter'))
  _map('n', 'F', _api.live_filter.clear, _opts('Clean Filter'))
  -- node operation
  _map('n', '<CR>', _api.node.open.edit, _opts('Open'))
  _map('n', 'l', _api.node.open.edit, _opts('Open'))
  _map('n', '<2-LeftMouse>', _api.node.open.edit, _opts('Open'))
  _map('n', '<Tab>', _api.node.open.preview, _opts('Open Preview'))
  _map('n', 's', _api.node.run.system, _opts('Run System'))
  _map('n', '.', _api.node.run.cmd, _opts('Run Command'))
  _map('n', 'gh', _api.node.show_info_popup, _opts('Info'))
  -- tree operation
  _map('n', 'q', _api.tree.close, _opts('Close'))
  _map('n', 'zm', _api.tree.collapse_all, _opts('Collapse'))
  _map('n', 'zr', _api.tree.expand_all, _opts('Expand All'))
  _map('n', 'H', _api.tree.change_root_to_parent, _opts('Up'))
  _map('n', 'R', _api.tree.reload, _opts('Refresh'))
  _map('n', 'g?', _api.tree.toggle_help, _opts('Help'))
  -- toggle display
  _map('n', 'tg', _api.tree.toggle_gitignore_filter, _opts('Toggle Git Ignore'))
  _map('n', 'th', _api.tree.toggle_hidden_filter, _opts('Toggle Dotfiles'))
  _map('n', 'tf', _api.tree.toggle_custom_filter, _opts('Toggle Hidden'))
  _map('n', 'tm', _api.marks.toggle, _opts('Toggle Bookmark'))
  -- file operation
  _map('n', 'a', _api.fs.create, _opts('Create'))
  _map('n', 'd', _api.fs.remove, _opts('Delete'))
  _map('n', 'c', _api.fs.copy.node, _opts('Copy'))
  _map('n', 'x', _api.fs.cut, _opts('Cut'))
  _map('n', 'p', _api.fs.paste, _opts('Paste'))
  _map('n', 'r', _api.fs.rename, _opts('Rename'))
  _map('n', '<C-r>', _api.fs.rename_sub, _opts('Rename: Omit Filename'))
  _map('n', 'y', _api.fs.copy.filename, _opts('Copy Name'))
  _map('n', 'gy', _api.fs.copy.relative_path, _opts('Copy Relative Path'))
  _map('n', 'gY', _api.fs.copy.absolute_path, _opts('Copy Absolute Path'))
end

function M.nvim_spectre_keymap()
  local mapping={
    ['toggle_line'] = {
        map = "dd",
        cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
        desc = "toggle current item"
    },
    ['enter_file'] = {
        map = "<cr>",
        cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
        desc = "goto current file"
    },
    ['send_to_qf'] = {
        map = "<leader>q",
        cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
        desc = "send all item to quickfix"
    },
    ['replace_cmd'] = {
        map = "<leader>c",
        cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
        desc = "input replace vim command"
    },
    ['show_option_menu'] = {
        map = "<leader>o",
        cmd = "<cmd>lua require('spectre').show_options()<CR>",
        desc = "show option"
    },
    ['run_current_replace'] = {
      map = "<leader>rc",
      cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
      desc = "replace current line"
    },
    ['run_replace'] = {
        map = "<leader>R",
        cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
        desc = "replace all"
    },
    ['change_view_mode'] = {
        map = "<leader>v",
        cmd = "<cmd>lua require('spectre').change_view()<CR>",
        desc = "change result view mode"
    },
    ['change_replace_sed'] = {
      map = "trs",
      cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
      desc = "use sed to replace"
    },
    ['change_replace_oxi'] = {
      map = "tro",
      cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
      desc = "use oxi to replace"
    },
    ['toggle_live_update']={
      map = "tu",
      cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
      desc = "update change when vim write file."
    },
    ['toggle_ignore_case'] = {
      map = "ti",
      cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
      desc = "toggle ignore case"
    },
    ['toggle_ignore_hidden'] = {
      map = "th",
      cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
      desc = "toggle search hidden"
    },
    ['resume_last_search'] = {
      map = "<leader>l",
      cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
      desc = "resume last search before close"
    },

  }
  return mapping
end

return M
