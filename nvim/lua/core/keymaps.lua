-- Wrapper around vim.keymap.set that will
-- not create a keymap if a lazy key handler exists.
-- It will also set `silent` to true by default.

local M = {}

M.load = function(section)
  vim.schedule(function() M[section]() end)
end

M.general = function()
local function map(mode, lhs, rhs, opts)
  local modes = type(mode) == "string" and { mode } or mode

  -- do not create the keymap if a lazy keys handler exists
  if #modes > 0 then
    opts = opts or {}
    opts.silent = true
    if opts.remap and not vim.g.vscode then
      ---@diagnostic disable-next-line: no-unknown
      opts.remap = nil
    end
    vim.keymap.set(modes, lhs, rhs, opts)
  end
end
  -- Clear search with <esc>
  map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
  -- Move to window using the <ctrl> hjkl keys
  map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
  map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
  map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
  map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })
  -- Resize window using <ctrl> arrow keys
  map("n", "-", ":resize -2<cr>", { desc = "Decrease window height" })
  map("n", "=", ":resize +2<cr>", { desc = "Increase window height" })
  map("n", "_", ":vertical resize -2<cr>", { desc = "Decrease window width" })
  map("n", "+", ":vertical resize +2<cr>", { desc = "Increase window width" })
  -- Buffer/Window operation
  map("n", "<leader>w", ":w<CR>", { desc = "Save current buffer" })
  map("n", "<leader>W", ":w !sudo tee %<CR>", { desc = "Save current buffer with super priv" })
  map("n", "<leader>d", ":bd<CR>", { desc = "Close current buffer" })
  map("n", "<leader>q", ":q<CR>", { desc = "Close current window" })
  map("n", "<leader>Q", ":qa<CR>", { desc = "Close all windows" })

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

  map("n", '<leader>pc', ":Lazy check<CR>", { desc = "Check update" })
  map("n", '<leader>ps', ":Lazy sync<CR>", { desc = "Sync update" })
  map("n", '<leader>pp', ":Lazy home<CR>", { desc = "Open list" })
end

M.ufo = {
  { "zR", ":lua require'ufo'.openAllFolds()<CR>", silent = true, desc = "open all folds" },
  { "zM", ":lua require'ufo'.closeAllFolds()<CR>", silent = true, desc = "close all folds" },
  { "zr", ":lua require'ufo'.openFoldsExceptKinds()<CR>", silent = true, desc = "open next fold level" },
  { "zm", ":lua require'ufo'.closeFoldsWith()<CR>", silent = true, desc = "close next fold level" },
  { "z1", ":lua require'ufo'.closeFoldsWith(1)<CR>", silent = true, desc = "close fold level 1" },
  { "z2", ":lua require'ufo'.closeFoldsWith(2)<CR>", silent = true, desc = "close fold level 2" },
  { "z3", ":lua require'ufo'.closeFoldsWith(3)<CR>", silent = true, desc = "close fold level 3" },
  { "z4", ":lua require'ufo'.closeFoldsWith(4)<CR>", silent = true, desc = "close fold level 4" },
}

M.floaterm = {
    { "<C-\\>", ":FloatermToggle<CR>",  silent = true },
    { '<leader>er', ":FloatermNew ranger<CR>", silent = true, desc = "Open ranger" },
    { '<leader>gl', ":FloatermNew lazygit<CR>", silent = true, desc = "Open ranger" },
}
M.floaterm_func = function()
  vim.keymap.set("t", "<C-\\>", [[<C-\><C-n>:FloatermToggle<CR>]], { silent = true })
end

M.lspconfig = {
  { "K", vim.lsp.buf.hover, silent = true, desc = "show hover" },

  { "gd", vim.lsp.buf.definition, silent = true, desc = "goto definition" },
  { "gD", vim.lsp.buf.declaration, silent = true, desc = "goto declaration" },
  { "gt", vim.lsp.buf.type_definition, silent = true, desc = "goto definition type", },
  { "gr", vim.lsp.buf.references, silent = true, desc = "goto references" },
  { "gi", vim.lsp.buf.implementation, silent = true, desc = "goto implementation" },
  { "gs", vim.lsp.buf.document_symbol, silent = true, desc = "show document symbol " },
  { "gh", vim.lsp.buf.signature_help, silent = true, desc = "show signature help" },

  { "<leader>la", vim.lsp.buf.code_action, silent = true, desc = "code action" },
  { "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, silent = true, desc = "formatting" },
  { "<leader>ll", silent = true, desc = ":LspLog<CR>", "Lsp server log" },
  { "<leader>li", silent = true, desc = ":LspInfo<CR>", "Lsp server Info" },
  { "<leader>lr", vim.lsp.buf.rename, silent = true, desc = "rename" },

  { "<leader>ldf", vim.diagnostic.open_float, silent = true, desc = "Diagnostic setloclist", },
  { "<leader>ldq", vim.diagnostic.setloclist, silent = true, desc = "Diagnostic setloclist", },

  { "<leader>lwa", vim.lsp.buf.add_workspace_folder, silent = true, desc = "Add workspace folder" },
  { "<leader>lwr", vim.lsp.buf.remove_workspace_folder, silent = true, desc = "Remove workspace folder" },
  { "<leader>lwl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, silent = true, desc = "List workspace folders" },

  { "[d", function() vim.diagnostic.goto_prev { float = { border = "rounded" } } end, silent = true, desc = "Goto prev" },
  { "]d", function() vim.diagnostic.goto_next { float = { border = "rounded" } } end, silent = true, desc = "Goto next" },
}

M.sqls = function(bufnr)
    local function _map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
    end
    _map('n', '<leader>xx', ":SqlsExecuteQuery<CR>", 'Stage hunk')
    _map('n', '<leader>xX', ":SqlsExecuteQueryVertical<CR>", 'Reset hunk')
    _map('v', '<leader>xx', "<Plug>(sqls-execute-query)", 'Stage hunk')
    _map('v', '<leader>xX', "<Plug>(sqls-execute-query-vertical)", 'Reset hunk')
end

M.dap = {
  { "<leader>Db", ":lua require'dap'.step_back()<CR>", silent = true, desc = "step back" },
  { "<leader>DB", ":lua require'dap'.toggle_breakpoint()<CR>", silent = true, desc = "toggle breakpoint" },
  { "<leader>Dc", ":lua require'dap'.continue()<CR>", silent = true, desc = "continue" },
  { "<leader>DD", ":lua require'dapui'.toggle()<CR>", silent = true, desc = "Toggle UI" },
  { "<leader>Dr", ":lua require'dap'.run_to_cursor()<CR>", silent = true, desc = "run to cursor" },
  { "<leader>Dd", ":lua require'dap'.disconnect()<CR>", silent = true, desc = "disconnect" },
  { "<leader>Dg", ":lua require'dap'.session()<CR>", silent = true, desc = "get session" },
  { "<leader>Di", ":lua require'dap'.step_into()<CR>", silent = true, desc = "step into" },
  { "<leader>Dl", ":lua require'dap'.repl.toggle()<CR>", silent = true, desc = "toggle repl" },
  { "<leader>Do", ":lua require'dap'.step_over()<CR>", silent = true, desc = "step over" },
  { "<leader>Du", ":lua require'dap'.step_out()<CR>", silent = true, desc = "step out" },
  { "<leader>Dp", ":lua require'dap'.pause()<CR>", silent = true, desc = "pause" },
  { "<leader>Ds", ":lua require'dap'.continue()<CR>", silent = true, desc = "start" },
  { "<leader>Dq", ":lua require'dap'.close()<CR>", silent = true, desc = "quit" },

  -- F-map alias DAP keymaps
  { "<F5>", ":lua require'dap'.continue()<CR>", silent = true },
  { "<S-F5>", ":lua require'dap'.run_to_cursor()<CR>", silent = true },
  { "<F9>", ":lua require'dap'.toggle_breakpoint()<CR>", silent = true },
  { "<S-F9>", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", silent = true },
  { "<S-F8>", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", silent = true },
  { "<F10>", ":lua require'dap'.step_over()<CR>", silent = true },
  { "<F11>", ":lua require'dap'.step_into()<CR>", silent = true },
  { "<S-F11>", ":lua require'dap'.step_out()<CR>", silent = true },
  -- { "",  ":lua require'dap'.pause()<CR>" )
  { "<F12>", ":lua require'dap'.run_last()<CR>", silent = true },
  { "<S-F12>", ":lua require'dap'.terminate()<CR>", silent = true },
  -- { "",     ":lua require'dap'.repl.toggle()<CR>", silent = true },
}

M.telescope = {
  { "<leader>fa", ":Telescope find_files follow=true no_ignore=true hidden=true <CR>", silent = true, desc = "Find all" },
  { "<leader>fc", ":Telescope commands<CR>", silent = true, desc = "Commands" },
  { "<leader>fe", ":Telescope emoji<CR>", silent = true, desc = "Checkout branch" },
  { "<leader>ff", ":Telescope find_files<CR>", silent = true, desc = "Find File" },
  { "<leader>fh", ":Telescope help_tags<CR>", silent = true, desc = "Find Help" },
  { "<leader>fH", ":Telescope highlights<CR>", silent = true, desc = "Find highlight groups" },
  { "<leader>fM", ":Telescope man_pages<CR>", silent = true, desc = "Man Pages" },
  { "<leader>fl", ":Telescope live_grep<CR>", silent = true, desc = "Text" },
  { "<leader>fk", ":Telescope keymaps<CR>", silent = true, desc = "Keymaps" },
  { "<leader>fo", ":Telescope oldfiles<CR>", silent = true, desc = "Find oldfiles" },
  { "<leader>ft", ":lua require('telescope.builtin').colorscheme {enable_preview=true}<CR>", silent = true, desc = "Colorscheme with Preview", },
  { "<leader>fz", ":Telescope current_buffer_fuzzy_find<CR>", silent = true, desc = "Find in current buffer" },

  { "<leader>gc", ":Telescope git_commits<CR>", silent = true, desc = "Open changed file" },
  { "<leader>gg", ":Telescope git_status<CR>", silent = true, desc = "Open changed file" },
}

M.autosession = {
  {"<leader>ss", ":SessionSave<CR>", "save session" },
  {"<leader>sl", ":SessionRestore<CR>", "load session" },
}
M.diffview = {
  { "<leader>gd", ":DiffviewOpen<CR>", silent = true, desc = "Git diff" },
  { "<leader>gh", ":DiffviewFileHistory %<CR>", silent = true, desc = "Show file history" },
}
M.rest = {
  { "<leader>hh", "<Plug>RestNvim", silent = true, desc = "run the request under the cursor" },
  { "<leader>hp", "<Plug>RestNvimPreview", silent = true, desc = "preview the request cURL command" },
  { "<leader>hl", "<Plug>RestNvimLast", silent = true, desc = "re-run the last request" },
}
M.trouble = {
  { "<leader>ldd", ":TroubleToggle<CR>", silent = true, desc =  "Open Diagnostic List" },
}
M.noice = {
  { "<leader><Esc>", ":Noice dismiss<CR>", silent = true, desc = "Dismiss noice" },
  { "<leader>fn", ":Noice telescope<CR>", silent = true, desc = "Find noice" },
}
M.project = {
  { "<leader>fp", ":Telescope projects<CR>", silent = true, desc = "Find Projects" },
}

return M
