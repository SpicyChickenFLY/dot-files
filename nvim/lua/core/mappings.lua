local map = require("core.utils").map

local M = {}

M.load_mappings = function(section)
  vim.schedule(function()
    M[section]()
  end)
end

M.general = function()
  map("n", "<ESC>", ":nohl<CR>")
  -- Move around windows & split window
  map("n", "<C-h>", "<C-w>h")
  map("n", "<C-j>", "<C-w>j")
  map("n", "<C-k>", "<C-w>k")
  map("n", "<C-l>", "<C-w>l")
  -- Resize window
  map("n", "-", ":resize -2<CR>")
  map("n", "=", ":resize +2<CR>")
  map("n", "_", ":vertical resize -5<CR>")
  map("n", "+", ":vertical resize +5<CR>")
  -- Buffer/Window operation
  map("n", "<leader>w", ":w<cr>", { desc = "Save current buffer" })
  map("n", "<leader>W", ":w !sudo tee %<cr>", { desc = "Save current buffer with super priv" })
  map("n", "<leader>d", ":bd<cr>", { desc = "Close current buffer" })
  map("n", "<leader>q", ":q<cr>", { desc = "Close current window" })
  map("n", "<leader>Q", ":qa<cr>", { desc = "Close all windows" })

  -- Show the syntax highlight group under cursor
  map("n", "gl", '<cmd>echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . "> trans<" . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>')
  map("n", "gL", '<cmd>Inspect!<cr>')

  -- Quick exit insert mode
  map("i", "jj", "<ESC>")
  map("i", "jk", "<ESC>:w<CR>")
  -- Emacs-like navigation
  map("i", "<C-a>", "<Home>")
  map("i", "<C-e>", "<End>")
  map("i", "<C-b>", "<Left>")
  map("i", "<C-f>", "<Right>")
  map("i", "<C-n>", "<Down>")
  map("i", "<C-p>", "<Up>")
  -- Content operation
  map("i", "<C-v>", "<ESC>pi")
end

M.bufferline = function()
  local wk = require("which-key")
  local mappings = {
    ['<leader>bs'] = { name = "Sort Buffers" },
    ['<leader>j'] = { ":BufferLineCyclePrev<CR>", "next buffer" },
    ['<leader>k'] = { ":BufferLineCycleNext<CR>", "prev buffer" },
  }
  wk.register(mappings)
end

M.lazy = function()
  local wk = require("which-key")
  local mappings = {
    ['<leader>pc'] = { ":Lazy check<CR>", "Check update" },
    ['<leader>ps'] = { ":Lazy sync<CR>", "Sync update" },
    ['<leader>pp'] = { ":Lazy home<CR>", "Open list" },
  }
  wk.register(mappings)
end

M.floaterm = function()
  map("n", "<C-\\>", ":FloatermToggle<CR>")
  map("t", "<C-\\>", [[<C-\><C-n>:FloatermToggle<CR>]])
  local wk = require("which-key")
  local mappings = {
    ['<leader>er'] = { ":FloatermNew ranger<CR>", "Open ranger" },
    ['<leader>gl'] = { ":FloatermNew lazygit<CR>", "Open ranger" },
  }
  wk.register(mappings)
end

M.telescope = function()
  local wk = require("which-key")
  local mappings = {
    ["<leader>fa"] = { ":Telescope find_files follow=true no_ignore=true hidden=true <CR>",
      "Find all" },
    ['<leader>fc'] = { ":Telescope commands<cr>", "Commands" },
    ['<leader>fe'] = { ":Telescope emoji<cr>", "Checkout branch" },
    ['<leader>ff'] = { ":Telescope find_files<cr>", "Find File" },
    ['<leader>fh'] = { ":Telescope help_tags<cr>", "Find Help" },
    ['<leader>fH'] = { ":Telescope highlights<cr>", "Find highlight groups" },
    ['<leader>fM'] = { ":Telescope man_pages<cr>", "Man Pages" },
    ['<leader>fl'] = { ":Telescope live_grep<cr>", "Text" },
    ['<leader>fk'] = { ":Telescope keymaps<cr>", "Keymaps" },
    ["<leader>fo"] = { ":Telescope oldfiles<cr>", "Find oldfiles" },
    ['<leader>fp'] = {
      ":lua require('telescope.builtin').colorscheme {enable_preview=true}<cr>",
      "Colorscheme with Preview",
      },
    ["<leader>fz"] = { ":Telescope current_buffer_fuzzy_find<cr>", "Find in current buffer" },

    ["<leader>gc"] = { ":Telescope git_commits<cr>", "Open changed file" },
    ["<leader>gg"] = { ":Telescope git_status<cr>", "Open changed file" },
  }
  wk.register(mappings)
end

M.gitsigns = function()
  local wk = require("which-key")
  local mappings = {
    ["<leader>gb"] = { ":lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    ["<leader>gs"] = { ":lua require 'gitsigns'.stage_hunk()<cr>", "Stage" },
    ["<leader>gr"] = { ":lua require 'gitsigns'.reset_hunk()<cr>", "Reset" },
    ["<leader>gp"] = { ":lua require 'gitsigns'.preview_hunk()<cr>", "Preview" },
    ["]c"] = {
      function()
        if vim.wo.diff then return "]c" end
        vim.schedule(function() require("gitsigns").next_hunk() end)
        return "<Ignore>"
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },

    ["[c"] = {
      function()
        if vim.wo.diff then return "[c" end
        vim.schedule(function() require("gitsigns").prev_hunk() end)
        return "<Ignore>"
      end,
      "Jump to prev hunk",
      opts = { expr = true },
    },
  }
  wk.register(mappings)

  local visual_mappings = {
    s = { ":lua require 'gitsigns'.stage_hunk()<cr>", "Stage" },
    r = { ":lua require 'gitsigns'.reset_hunk()<cr>", "Reset" },
  }
end

M.lspconfig = function()
  local wk = require("which-key")
  local mappings = {
    ["K"] = { function() vim.lsp.buf.hover() end, "show hover" },

    ["gd"] = { function() vim.lsp.buf.definition() end, "goto definition" },
    ["gD"] = { function() vim.lsp.buf.declaration() end, "goto declaration" },
    ["gt"] = { function() vim.lsp.buf.type_definition() end, "goto definition type", },
    ["gr"] = { function() vim.lsp.buf.references() end, "goto references" },
    ["gi"] = { function() vim.lsp.buf.implementation() end, "goto implementation" },
    ["gs"] = { function() vim.lsp.buf.document_symbol() end, "show document symbol "},
    ["gh"] = { function() vim.lsp.buf.signature_help() end, "show signature help" },


    ["<leader>la"] = { function() vim.lsp.buf.code_action() end, "code action" },
    ["<leader>lf"] = { function() vim.lsp.buf.format { async = true } end, "formatting" },
    ["<leader>ll"] = { ":LspLog<CR>", "Lsp server log" },
    ["<leader>li"] = { ":LspInfo<CR>", "Lsp server Info" },
    ["<leader>lr"] = { function() vim.lsp.buf.rename() end, "rename" },
    ["<leader>ldq"] = { function() vim.diagnostic.setloclist() end, "Diagnostic setloclist", },

    ["<leader>lwa"] = { function() vim.lsp.buf.add_workspace_folder() end, "Add workspace folder" },
    ["<leader>lwr"] = { function() vim.lsp.buf.remove_workspace_folder() end, "Remove workspace folder" },
    ["<leader>lwl"] = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "List workspace folders" },

    ["[d"] = { function() vim.diagnostic.goto_prev { float = { border = "rounded" } } end, "Goto prev" },
    ["]d"] = { function() vim.diagnostic.goto_next { float = { border = "rounded" } } end, "Goto next" },
  }
  wk.register(mappings)
end

M.dap = function()
  local wk = require("which-key")
  local mappings = {
    ["<leader>Db"] = { ":lua require'dap'.step_back()<cr>", "step back" },
    ["<leader>DB"] = { ":lua require'dap'.toggle_breakpoint()<cr>", "toggle breakpoint" },
    ["<leader>Dc"] = { ":lua require'dap'.continue()<cr>", "continue" },
    ["<leader>DD"] = { ":lua require'dapui'.toggle()<cr>", "Toggle UI" },
    ["<leader>Dr"] = { ":lua require'dap'.run_to_cursor()<cr>", "run to cursor" },
    ["<leader>Dd"] = { ":lua require'dap'.disconnect()<cr>", "disconnect" },
    ["<leader>Dg"] = { ":lua require'dap'.session()<cr>", "get session" },
    ["<leader>Di"] = { ":lua require'dap'.step_into()<cr>", "step into" },
    ["<leader>Dl"] = { ":lua require'dap'.repl.toggle()<cr>", "toggle repl" },
    ["<leader>Do"] = { ":lua require'dap'.step_over()<cr>", "step over" },
    ["<leader>Du"] = { ":lua require'dap'.step_out()<cr>", "step out" },
    ["<leader>Dp"] = { ":lua require'dap'.pause()<cr>", "pause" },
    ["<leader>Ds"] = { ":lua require'dap'.continue()<cr>", "start" },
    ["<leader>Dq"] = { ":lua require'dap'.close()<cr>", "quit" },
  }
  wk.register(mappings)

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
end

M.nvimtree = function()
  local wk = require("which-key")
  local mappings = {
    ["<leader>ee"] = { ":NvimTreeFocus<CR>", "Open" },
    ["<leader>ef"] = { ":NvimTreeFindFile<CR>", "Find File" },
    ["<leader>er"] = { ":Ranger<CR>", "Open" },
  }
  wk.register(mappings)
end

M.spectre = function()
  local wk = require("which-key")
  local mappings = {
    ["<leader>rr"] = { '<cmd>lua require("spectre").open()<cr>', "open" },
    ["<leader>rw"] = { '<cmd>lua require("spectre").open_visual({select_word=true})<cr>', "open with current word" },
    ["<leader>rf"] = { 'viw:lua require("spectre").open_file_search()<cr>', "open file search" },
  }
  wk.register(mappings)
end

M.autosession = function()
  local wk = require("which-key")
  local mappings = {
    ["<leader>ss"] = { ":SessionSave<cr>", "save session" },
    ["<leader>sl"] = { ":SessionRestore<cr>", "load session" },
  }
  wk.register(mappings)
end

M.diffview = function()
  local wk = require("which-key")
  local mappings = {
    ["<leader>gd"] = { ":DiffviewOpen<cr>", "Git diff" },
    ["<leader>gh"] = { ":DiffviewFileHistory %<cr>", "Show file history" },
  }
  wk.register(mappings)
end

M.rest = function()
  local wk = require("which-key")
  local mappings = {
      ["<leader>Hh"] = { "<Plug>RestNvim", "run the request under the cursor" },
      ["<leader>Hp"] = { "<Plug>RestNvimPreview", "preview the request cURL command" },
      ["<leader>Hl"] = { "<Plug>RestNvimLast", "re-run the last request" },
  }
  wk.register(mappings)
end

M.dadbod = function()
  local wk = require("which-key")
  local mappings = {
    ["<leader>xx"] = { "<Cmd>DBUIToggle<Cr>", "Toggle UI" },
    ["<leader>xf"] = { "<Cmd>DBUIFindBuffer<Cr>", "Find buffer" },
    ["<leader>xq"] = { "<Cmd>DBUILastQueryInfo<Cr>", "Last query info" },
    ["<leader>xr"] = { "<Cmd>DBUIRenameBuffer<Cr>", "Rename buffer" },
  }
  wk.register(mappings)
end

M.ufo = function()
  local wk = require("which-key")
  local mappings = {
    ["zR"] = { ":lua require'ufo'.openAllFolds()<CR>", "open all folds" },
    ["zM"] = { ":lua require'ufo'.closeAllFolds()<CR>", "close all folds" },
    ["zr"] = { ":lua require'ufo'.openFoldsExceptKinds()<CR>", "open next fold level" },
    ["zm"] = { ":lua require'ufo'.closeFoldsWith()<CR>", "close next fold level" },
    ["z1"] = { ":lua require'ufo'.closeFoldsWith(1)<CR>", "close fold level 1" },
    ["z2"] = { ":lua require'ufo'.closeFoldsWith(2)<CR>", "close fold level 2" },
    ["z3"] = { ":lua require'ufo'.closeFoldsWith(3)<CR>", "close fold level 3" },
    ["z4"] = { ":lua require'ufo'.closeFoldsWith(4)<CR>", "close fold level 4" },
  }
  wk.register(mappings)
end

M.hop = function()
  local hop = require("hop")
  local directions = require("hop.hint").HintDirection
  map("n", "f", function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true }) end)
  map("n", "F", function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true }) end)
  map("n", "t", function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }) end)
  map("n", "T", function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }) end)
end

M.mason = function()
  local wk = require("which-key")
  local mappings = {
    ["<leader>lm"] = { ":Mason<CR>", "Open Manager(Mason)"},
  }
  wk.register(mappings)
end

M.iconpicker = function()
  local wk = require("which-key")
  local mappings = {
    ["<leader>fi"] = { ":IconPickerNormal nerd_font_v3 alt_font emoji symbols html_colors<cr>", "Find Icon" },
  }
  wk.register(mappings)
end

M.whichkey = function()
  local wk = require("which-key")
  local leader_mapping = {
    b = { name = "Buffer", },
    D = { name = "Debug Tool" },
    e = { name = "File Explorer", },
    f = { name = "Find",
    },
    g = { name = "Git", },
    l = { name = "LSP" },
    p = { name = "Plugin(Lazy)" },
    r = { name = "Replacer" },
    s = { name = "Session" },
    H = { name = "Http Tool", },
    x = { name = "Database Tool", },
  }

  local visual_leader_mapping = { g = { name = "Git", } }

  wk.register(leader_mapping, { prefix = "<leader>" })
  wk.register(visual_leader_mapping, { prefix = "<leader>", mode = "v" })
end

function M.nvim_tree_keymap(bufnr)
  local _api = require("nvim-tree.api")

  local function _opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  local _map = vim.keymap.set
  _map("n", "h", _api.node.navigate.parent, _opts("Parent Directory"))
  _map("n", "J", _api.node.navigate.sibling.next, _opts("Next Sibling"))
  _map("n", "K", _api.node.navigate.sibling.prev, _opts("Previous Sibling"))
  _map("n", "[c", _api.node.navigate.git.prev, _opts("Prev Git"))
  _map("n", "]c", _api.node.navigate.git.next, _opts("Next Git"))
  _map("n", "[e", _api.node.navigate.diagnostics.prev, _opts("Prev Diagnostic"))
  _map("n", "]e", _api.node.navigate.diagnostics.next, _opts("Next Diagnostic"))
  -- filter
  _map("n", "f", _api.live_filter.start, _opts("Filter"))
  _map("n", "F", _api.live_filter.clear, _opts("Clean Filter"))
  -- node operation
  _map("n", "<CR>", _api.node.open.edit, _opts("Open"))
  _map("n", "l", _api.node.open.edit, _opts("Open"))
  _map("n", "<2-LeftMouse>", _api.node.open.edit, _opts("Open"))
  _map("n", "<Tab>", _api.node.open.preview, _opts("Open Preview"))
  _map("n", "s", _api.node.run.system, _opts("Run System"))
  _map("n", ".", _api.node.run.cmd, _opts("Run Command"))
  _map("n", "gh", _api.node.show_info_popup, _opts("Info"))
  -- tree operation
  _map("n", "q", _api.tree.close, _opts("Close"))
  _map("n", "zm", _api.tree.collapse_all, _opts("Collapse"))
  _map("n", "zr", _api.tree.expand_all, _opts("Expand All"))
  _map("n", "H", _api.tree.change_root_to_parent, _opts("Up"))
  _map("n", "R", _api.tree.reload, _opts("Refresh"))
  _map("n", "g?", _api.tree.toggle_help, _opts("Help"))
  -- toggle display
  _map("n", "tg", _api.tree.toggle_gitignore_filter, _opts("Toggle Git Ignore"))
  _map("n", "th", _api.tree.toggle_hidden_filter, _opts("Toggle Dotfiles"))
  _map("n", "tf", _api.tree.toggle_custom_filter, _opts("Toggle Hidden"))
  _map("n", "tm", _api.marks.toggle, _opts("Toggle Bookmark"))
  -- file operation
  _map("n", "a", _api.fs.create, _opts("Create"))
  _map("n", "d", _api.fs.remove, _opts("Delete"))
  _map("n", "c", _api.fs.copy.node, _opts("Copy"))
  _map("n", "x", _api.fs.cut, _opts("Cut"))
  _map("n", "p", _api.fs.paste, _opts("Paste"))
  _map("n", "r", _api.fs.rename, _opts("Rename"))
  _map("n", "<C-r>", _api.fs.rename_sub, _opts("Rename: Omit Filename"))
  _map("n", "y", _api.fs.copy.filename, _opts("Copy Name"))
  _map("n", "gy", _api.fs.copy.relative_path, _opts("Copy Relative Path"))
  _map("n", "gY", _api.fs.copy.absolute_path, _opts("Copy Absolute Path"))
end

function M.nvim_spectre_keymap()
  local mapping = {
    ["toggle_line"] = {
      map = "dd",
      cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
      desc = "toggle item",
    },
    ["enter_file"] = {
      map = "<cr>",
      cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
      desc = "open file",
    },
    ["send_to_qf"] = {
      map = "<C-q>",
      cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
      desc = "send all items to quickfix",
    },
    ["replace_cmd"] = {
      map = "<leader>c",
      cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
      desc = "input replace command",
    },
    ["show_option_menu"] = {
      map = "<leader>o",
      cmd = "<cmd>lua require('spectre').show_options()<CR>",
      desc = "show options",
    },
    ["run_current_replace"] = {
      map = "<leader>r",
      cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
      desc = "replace item",
    },
    ["run_replace"] = {
      map = "<leader>R",
      cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
      desc = "replace all",
    },
    -- only show replace text in result UI
    ["change_view_mode"] = {
      map = "<leader>v",
      cmd = "<cmd>lua require('spectre').change_view()<CR>",
      desc = "change result view mode",
    },
    ["change_replace_sed"] = {
      map = "trs",
      cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
      desc = "use sed to replace",
    },
    ["change_replace_oxi"] = {
      map = "tro",
      cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
      desc = "use oxi to replace",
    },
    ["toggle_live_update"] = {
      map = "tu",
      cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
      desc = "update when vim writes to file",
    },
    -- only work if the find_engine following have that option
    ["toggle_ignore_case"] = {
      map = "ti",
      cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
      desc = "toggle ignore case",
    },
    ["toggle_ignore_hidden"] = {
      map = "th",
      cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
      desc = "toggle search hidden",
    },
    ["resume_last_search"] = {
      map = "<leader>l",
      cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
      desc = "repeat last search",
    },
    ["select_template"] = {
      map = "<leader>rp",
      cmd = "<cmd>lua require('spectre.actions').select_template()<CR>",
      desc = "pick template",
    },
  }
  return mapping
end

return M
