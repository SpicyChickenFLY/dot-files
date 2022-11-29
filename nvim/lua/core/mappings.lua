local map = require("utils").map

-- buffer navigation
map("n", "<leader>j", ":BufferPrevious<cr>")
map("n", "<leader>k", ":BufferNext<cr>")
map("n", "<leader>d", ":BufferClose<cr>")
-- move around windows & split window
map("n", "<A-h>", "<C-w>h")
map("n", "<A-j>", "<C-w>j")
map("n", "<A-k>", "<C-w>k")
map("n", "<A-l>", "<C-w>l")
map("n", "<A-H>", ":vsp<CR>:bprevious<CR><C-w>h")
map("n", "<A-J>", ":sp<CR>:bprevious<CR><C-w>j")
map("n", "<A-K>", ":sp<CR>:bprevious<CR><C-w>k")
map("n", "<A-L>", ":vsp<CR>:bprevious<CR><C-w>l")
-- resize window
map("n", "-", ":resize -2<CR>")
map("n", "=", ":resize +2<CR>")
map("n", "_", ":vertical resize -2<CR>")
map("n", "+", ":vertical resize +2<CR>")
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
map("n", "<C-l>", ":FloatermToggle<CR>")
map("t", "<C-l>", [[<C-\><C-n>]])

-- NOTE: command <g> mapping
map("n", "gd", vim.lsp.buf.definition, { desc = "goto func def" })
map("n", "gD", vim.lsp.buf.type_definition, { desc = "goto type def" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "goto if impl" })
map("n", "gr", vim.lsp.buf.references, { desc = "goto refer" })
map("n", "gs", vim.lsp.buf.document_symbol, { desc = "show document symbol " })
map("n", "gh", vim.lsp.buf.hover, { desc = "show hover info" })

map("n", "<F5>",   ":lua require'dap'.continue()<CR>")
map("n", "<S-F5>",   ":lua require'dap'.run_to_cursor()<CR>")
map("n", "<F9>",   ":lua require'dap'.toggle_breakpoint()<CR>")
map("n", "<S-F9>", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
map("n", "<S-F8>",   ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
map("n", "<F10>",  ":lua require'dap'.step_over()<CR>")
map("n", "<F11>",  ":lua require'dap'.step_into()<CR>")
map("n", "<S-F11>",":lua require'dap'.step_out()<CR>")
map("n", "<F12>",  ":lua require'dap'.run_last()<CR>")
map("n", "<S-F12>",   ":lua require'dap'.terminate()<CR>")
-- map("n", "<>",       ":lua require'dap'.repl.open()<CR>")

-- NOTE: command goto with [, ]
map("n", "[d", function()
  vim.diagnostic.goto_prev()
end, { desc = "goto prev" })
map("n", "]d", function()
  vim.diagnostic.goto_next()
end, { desc = "goto_next" })

-- NOTE: leader mapping
local leader_mapping = {
  ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle current line" },
  ["w"] = { ":w<cr>", "Save current buffer" },
  l = {
    name = "LSP",
    r = { vim.lsp.buf.rename, "rename var/func/class" },
    s = { vim.lsp.buf.signature_help, "signature help" },
    a = { vim.lsp.buf.code_action, "action for err/warn" },
    f = {
      function()
        vim.lsp.buf.format({ async = true })
      end,
      "format file",
    },
    w = {
      name = "workspace",
      a = { vim.lsp.buf.add_workspace_folder, "add" },
      r = { vim.lsp.buf.remove_workspace_folder, "remove" },
      l = {
        function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end,
        "list workspaces",
      },
    },
    d = {
      name = "diagnostic",
      a = { vim.diagnostic.setqflist, "quick fix" },
      e = {
        function()
          vim.diagnostic.setqflist({ severity = "E" })
        end,
        "error quick fix list",
      },
      w = {
        function()
          vim.diagnostic.setqflist({ severity = "W" })
        end,
        "warn quick fix list",
      },
      l = { vim.diagnostic.setloclist, "local list" },
    },
  },
  f = {
    name = "Find",
    b = { ":Telescope git_branches<cr>", "Checkout branch" },
    f = { ":Telescope find_files<cr>", "Find File" },
    h = { ":Telescope help_tags<cr>", "Find Help" },
    H = { ":Telescope highlights<cr>", "Find highlight groups" },
    M = { ":Telescope man_pages<cr>", "Man Pages" },
    l = { ":Telescope live_grep<cr>", "Text" },
    k = { ":Telescope keymaps<cr>", "Keymaps" },
    C = { ":Telescope commands<cr>", "Commands" },
    p = {
      ":lua require('telescope.builtin').colorscheme({enable_preview=true})<cr>",
      "Colorscheme with Preview",
    },
  },
  r = {
    name = "Replacer",
    s = { '<cmd>lua require("spectre").open()<cr>', "open" },
    w = { '<cmd>lua require("spectre").open_visual({select_word=true})<cr>', "open with current word" },
    f = { 'viw:lua require("spectre").open_file_search()<cr>', "open file search" },
  },
  s = {
    name = "Session",
    s = { "<cmd>SaveSession<cr>", "save session" },
    l = { "<cmd>silent RestoreSession<cr>", "load session" },
  },
  d = {
    name = "Debug",
    t = { ":lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    b = { ":lua require'dap'.step_back()<cr>", "Step Back" },
    c = { ":lua require'dap'.continue()<cr>", "Continue" },
    C = { ":lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
    d = { ":lua require'dap'.disconnect()<cr>", "Disconnect" },
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
  g = {
    name = "Git",
    g = { ":lua require 'lvim.core.terminal'.lazygit_toggle()<cr>", "Lazygit" },
    j = { ":lua require 'gitsigns'.next_hunk({navigation_message=false})<cr>", "Next Hunk" },
    k = { ":lua require 'gitsigns'.prev_hunk({navigation_message=false})<cr>", "Prev Hunk" },
    l = { ":lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { ":lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { ":lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { ":lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { ":lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = { ":lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
    o = { ":Telescope git_status<cr>", "Open changed file" },
    b = { ":Telescope git_branches<cr>", "Checkout branch" },
    c = { ":Telescope git_commits<cr>", "Checkout commit" },
    C = { ":Telescope git_bcommits<cr>", "Checkout commit(for current file)" },
    d = { ":Gitsigns diffthis HEAD<cr>", "Git Diff" },
  },
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    r = { "<cmd>lua require('lvim.plugin-loader').recompile()<cr>", "Re-compile" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
}
local wk = require("which-key")
wk.register(leader_mapping, { prefix = "<leader>" })

--[[ map('n', '<C-E>', ':Vifm<CR>') ]]

-- file explorer
map("n", "<C-E>", ":NvimTreeFocus<CR>")
map("n", "<leader>tm", '<cmd>lua require("nvim-tree.api").marks.navigate.select()<cr>')
