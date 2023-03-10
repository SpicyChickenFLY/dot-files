local map = require("core.utils").map

map("n", "<ESC>", ":nohl<CR>")
-- buffer navigation
-- map("n", "<leader>j", ":BufferPrevious<CR>")
-- map("n", "<leader>k", ":BufferNext<CR>")
-- map("n", "<leader>d", ":BufferClose<CR>")
-- move around windows & split window
-- map("n", "<C-h>", "<C-w>h")
-- map("n", "<C-j>", "<C-w>j")
-- map("n", "<C-k>", "<C-w>k")
-- map("n", "<C-l>", "<C-w>l")
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
map("t", "<C-\\>", [[<C-\><C-n>]])

-- NOTE: command <z> mapping
map("n", "zR", ":lua require'ufo'.openAllFolds()<CR>", { desc = "open all folds" })
map("n", "zM", ":lua require'ufo'.closeAllFolds()<CR>", { desc = "close all folds" })
map("n", "zr", ":lua require('ufo').openFoldsExceptKinds()<CR>", { desc = "open next fold level"})
map("n", "zm", ":lua require('ufo').closeFoldsWith()<CR>", { desc = "close next fold level"})
map("n", "z1", ":lua require'ufo'.closeFoldsWith(1)<CR>", { desc = "close fold level 1" })
map("n", "z2", ":lua require'ufo'.closeFoldsWith(2)<CR>", { desc = "close fold level 2" })
map("n", "z3", ":lua require'ufo'.closeFoldsWith(3)<CR>", { desc = "close fold level 3" })
map("n", "z4", ":lua require'ufo'.closeFoldsWith(4)<CR>", { desc = "close fold level 4" })

-- NOTE: command <g> mapping
map("n", "gd", vim.lsp.buf.definition, { desc = "goto func def" })
map("n", "gD", vim.lsp.buf.type_definition, { desc = "goto type def" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "goto if impl" })
map("n", "gr", vim.lsp.buf.references, { desc = "goto refer" })
map("n", "gs", vim.lsp.buf.document_symbol, { desc = "show document symbol " })
map("n", "gh", vim.lsp.buf.hover, { desc = "show hover info" })

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

-- NOTE: command goto with [, ]
map("n", "[d", function() vim.diagnostic.goto_prev() end, { desc = "goto prev" })
map("n", "]d", function() vim.diagnostic.goto_next() end, { desc = "goto_next" })
map("n", "[c", ":lua require 'gitsigns'.prev_hunk({navigation_message=false})<cr>", { desc = "Prev Hunk" })
map("n", "]c", ":lua require 'gitsigns'.next_hunk({navigation_message=false})<cr>", { desc = "Next Hunk" })
map("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" })
map("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo comment" })

-- NOTE: leader mapping
local leader_mapping = {
  ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle current line" },
  d = { name = "Debug",
    d = { ":lua require'dapui'.toggle()<CR>", "Display debug UI" },
    t = { ":lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    b = { ":lua require'dap'.step_back()<cr>", "Step Back" },
    c = { ":lua require'dap'.continue()<cr>", "Continue" },
    C = { ":lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
    D = { ":lua require'dap'.disconnect()<cr>", "Disconnect" },
    g = { ":lua require'dap'.session()<cr>", "Get Session" },
    i = { ":lua require'dap'.step_into()<cr>", "Step Into" },
    o = { ":lua require'dap'.step_over()<cr>", "Step Over" },
    u = { ":lua require'dap'.step_out()<cr>", "Step Out" },
    p = { ":lua require'dap'.pause()<cr>", "Pause" },
    r = { ":lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    s = { ":lua require'dap'.continue()<cr>", "Start" },
    q = { ":lua require'dap'.close()<cr>", "Quit" },
    U = { ":lua require'dapui'.toggle()<cr>", "Toggle UI" },
  },
  e = { name = "File Explorer",
    e = { ":NvimTreeFocus<CR>", "Open" },
    f = { ":NvimTreeFindFile<CR>", "Find File" },
    r = { ":Ranger<CR>", "Open" },
  },
  f = { name = "Find",
    b = { ":Telescope git_branches<cr>", "Checkout branch" },
    e = { ":Telescope emoji<cr>", "Checkout branch" },
    f = { ":Telescope find_files<cr>", "Find File" },
    h = { ":Telescope help_tags<cr>", "Find Help" },
    H = { ":Telescope highlights<cr>", "Find highlight groups" },
    i = { ":IconPickerNormal<cr>", "Find Icon" },
    M = { ":Telescope man_pages<cr>", "Man Pages" },
    l = { ":Telescope live_grep<cr>", "Text" },
    k = { ":Telescope keymaps<cr>", "Keymaps" },
    C = { ":Telescope commands<cr>", "Commands" },
    p = { ":lua require('telescope.builtin').colorscheme({enable_preview=true})<cr>",
      "Colorscheme with Preview", },
  },
  g = { name = "Git",
    g = { ":Lazygit<cr>", "Lazygit" },
    h = { name = "Hunk",
      j = { ":lua require 'gitsigns'.next_hunk({navigation_message=false})<cr>", "Next" },
      k = { ":lua require 'gitsigns'.prev_hunk({navigation_message=false})<cr>", "Prev" },
      p = { ":lua require 'gitsigns'.preview_hunk()<cr>", "Preview" },
      s = { ":lua require 'gitsigns'.stage_hunk()<cr>", "Stage" },
      u = { ":lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage" },
      r = { ":lua require 'gitsigns'.reset_hunk()<cr>", "Reset" },
    },
    b = { name = "Buffer",
      r = { ":lua require 'gitsigns'.reset_buffer()<cr>", "Reset" },
      s = { ":lua require 'gitsigns'.stage_buffer()<cr>", "Stage" },
    },
    l = { ":lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    d = { ":Gitsigns diffthis HEAD<cr>", "Git Diff" },
    s = { ":Telescope git_status<cr>", "Open changed file" },
    B = { ":Telescope git_branches<cr>", "Checkout branch" },
    c = { ":Telescope git_commits<cr>", "Checkout commit" },
    C = { ":Telescope git_bcommits<cr>", "Checkout commit(for current file)" },
  },
  h = { name = "Http",
    h = { '<Plug>RestNvim', 'run the request under the cursor' },
    p = { '<Plug>RestNvimPreview', 'preview the request cURL command' },
    l = { '<Plug>RestNvimLast', 're-run the last request' },
  },
  j = { ":BufferLineCyclePrev<CR>", "next buffer" },
  k = { ":BufferLineCycleNext<CR>", "prev buffer" },
  l = { name = "LSP",
    r = { vim.lsp.buf.rename, "rename var/func/class" },
    s = { vim.lsp.buf.signature_help, "signature help" },
    a = { vim.lsp.buf.code_action, "action for err/warn" },
    f = { function() vim.lsp.buf.format({ async = true }) end,
      "format file",
    },
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
      x = { ":TroubleToggle<cr>", "Open" },
      w = { ":TroubleToggle workspace_diagnostics<cr>", "workspace" },
      d = { ":TroubleToggle document_diagnostics<cr>", "document" },
      q = { ":TroubleToggle quickfix<cr>", "quickfix" },
      l = { ":TroubleToggle loclist<cr>", "loclist" },
    },
  },
  o = { name = "Outline",
    o = { ":SymbolsOutline<CR>", "Open" },
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
    s = { "<cmd>SaveSession<cr>", "save session" },
    l = { "<cmd>silent RestoreSession<cr>", "load session" },
  },
  t = { name = "Todo",
    t = { ":TodoTrouble<cr>", "Open" },
    q = { ":TodoQuickFix<cr>", "quickfix" },
    l = { ":TodoLocList<cr>", "loclist" },
    f = { ":TodoTelescope<cr>", "find in telescope" },
  },
  w = { ":w<cr>", "Save current buffer" },
  W = { ":w !sudo tee %<cr>", "Save current buffer with super priv" },
  x = { name = "Database",
    x = { "<Cmd>DBUIToggle<Cr>", "Toggle UI" },
    f = { "<Cmd>DBUIFindBuffer<Cr>", "Find buffer" },
    q = { "<Cmd>DBUILastQueryInfo<Cr>", "Last query info" },
    r = { "<Cmd>DBUIRenameBuffer<Cr>", "Rename buffer"},
  },
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

--[[ map('n', '<C-E>', ':Vifm<CR>') ]]
