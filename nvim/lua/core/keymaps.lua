-- Wrapper around vim.keymap.set that will
-- not create a keymap if a lazy key handler exists.
-- It will also set `silent` to true by default.
local function map(mode, lhs, rhs, opts)
  local modes = type(mode) == "string" and { mode } or mode

  -- do not create the keymap if a lazy keys handler exists
  if #modes > 0 then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      ---@diagnostic disable-next-line: no-unknown
      opts.remap = nil
    end
    vim.keymap.set(modes, lhs, rhs, opts)
  end
end

local M = {}

M.load = function(section)
  vim.schedule(function() M[section]() end)
end

M.general = function()
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
    ['<leader>fc'] = { ":Telescope commands<CR>", "Commands" },
    ['<leader>fe'] = { ":Telescope emoji<CR>", "Checkout branch" },
    ['<leader>ff'] = { ":Telescope find_files<CR>", "Find File" },
    ['<leader>fh'] = { ":Telescope help_tags<CR>", "Find Help" },
    ['<leader>fH'] = { ":Telescope highlights<CR>", "Find highlight groups" },
    ['<leader>fM'] = { ":Telescope man_pages<CR>", "Man Pages" },
    ['<leader>fl'] = { ":Telescope live_grep<CR>", "Text" },
    ['<leader>fk'] = { ":Telescope keymaps<CR>", "Keymaps" },
    ["<leader>fo"] = { ":Telescope oldfiles<CR>", "Find oldfiles" },
    ['<leader>ft'] = {
      ":lua require('telescope.builtin').colorscheme {enable_preview=true}<CR>",
      "Colorscheme with Preview",
    },
    ["<leader>fz"] = { ":Telescope current_buffer_fuzzy_find<CR>", "Find in current buffer" },

    ["<leader>gc"] = { ":Telescope git_commits<CR>", "Open changed file" },
    ["<leader>gg"] = { ":Telescope git_status<CR>", "Open changed file" },
  }
  wk.register(mappings)
end

M.lspconfig = function()
  local wk = require("which-key")
  local mappings = {
    ["K"] = { vim.lsp.buf.hover, "show hover" },

    ["gd"] = { vim.lsp.buf.definition, "goto definition" },
    ["gD"] = { vim.lsp.buf.declaration, "goto declaration" },
    ["gt"] = { vim.lsp.buf.type_definition, "goto definition type", },
    ["gr"] = { vim.lsp.buf.references, "goto references" },
    ["gi"] = { vim.lsp.buf.implementation, "goto implementation" },
    ["gs"] = { vim.lsp.buf.document_symbol, "show document symbol " },
    ["gh"] = { vim.lsp.buf.signature_help, "show signature help" },


    ["<leader>la"] = { vim.lsp.buf.code_action, "code action" },
    ["<leader>lf"] = { function() vim.lsp.buf.format({ async = true }) end, "formatting" },
    ["<leader>ll"] = { ":LspLog<CR>", "Lsp server log" },
    ["<leader>li"] = { ":LspInfo<CR>", "Lsp server Info" },
    ["<leader>lr"] = { vim.lsp.buf.rename, "rename" },

    ["<leader>ldf"] = { vim.diagnostic.open_float, "Diagnostic setloclist", },
    ["<leader>ldq"] = { vim.diagnostic.setloclist, "Diagnostic setloclist", },

    ["<leader>lwa"] = { vim.lsp.buf.add_workspace_folder, "Add workspace folder" },
    ["<leader>lwr"] = { vim.lsp.buf.remove_workspace_folder, "Remove workspace folder" },
    ["<leader>lwl"] = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "List workspace folders" },

    ["[d"] = { function() vim.diagnostic.goto_prev { float = { border = "rounded" } } end, "Goto prev" },
    ["]d"] = { function() vim.diagnostic.goto_next { float = { border = "rounded" } } end, "Goto next" },
  }
  wk.register(mappings)
end

M.sqls = function()
  local wk = require("which-key")
  local normal_mappings = {
    ["<leader>x"] = { ":SqlsExecuteQuery<CR>", "Execute query" },
  }
  local visual_mappings = {
    ["<leader>x"] = { ":SqlsExecuteQuery<CR>", "Execute query" },
    ["<leader>X"] = { ":SqlsExecuteQueryVertical<CR>", "Execute query in vertical" },
  }
  wk.register(normal_mappings)
  wk.register(visual_mappings, { mode = "v" })
end

M.dap = function()
  local wk = require("which-key")
  local mappings = {
    ["<leader>Db"] = { ":lua require'dap'.step_back()<CR>", "step back" },
    ["<leader>DB"] = { ":lua require'dap'.toggle_breakpoint()<CR>", "toggle breakpoint" },
    ["<leader>Dc"] = { ":lua require'dap'.continue()<CR>", "continue" },
    ["<leader>DD"] = { ":lua require'dapui'.toggle()<CR>", "Toggle UI" },
    ["<leader>Dr"] = { ":lua require'dap'.run_to_cursor()<CR>", "run to cursor" },
    ["<leader>Dd"] = { ":lua require'dap'.disconnect()<CR>", "disconnect" },
    ["<leader>Dg"] = { ":lua require'dap'.session()<CR>", "get session" },
    ["<leader>Di"] = { ":lua require'dap'.step_into()<CR>", "step into" },
    ["<leader>Dl"] = { ":lua require'dap'.repl.toggle()<CR>", "toggle repl" },
    ["<leader>Do"] = { ":lua require'dap'.step_over()<CR>", "step over" },
    ["<leader>Du"] = { ":lua require'dap'.step_out()<CR>", "step out" },
    ["<leader>Dp"] = { ":lua require'dap'.pause()<CR>", "pause" },
    ["<leader>Ds"] = { ":lua require'dap'.continue()<CR>", "start" },
    ["<leader>Dq"] = { ":lua require'dap'.close()<CR>", "quit" },
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
  -- map("n", "",  ":lua require'dap'.pause()<CR>" )
  map("n", "<F12>", ":lua require'dap'.run_last()<CR>")
  map("n", "<S-F12>", ":lua require'dap'.terminate()<CR>")
  -- map("n", "",     ":lua require'dap'.repl.toggle()<CR>")
end

M.formatter = function()
  local wk = require("which-key")
  local mappings = {
    ["<leader>lf"] = { ":Format<CR>", "Format current buffer" },
  }
  wk.register(mappings)
end

M.autosession = function()
  local wk = require("which-key")
  local mappings = {
    ["<leader>ss"] = { ":SessionSave<CR>", "save session" },
    ["<leader>sl"] = { ":SessionRestore<CR>", "load session" },
  }
  wk.register(mappings)
end

M.diffview = function()
  local wk = require("which-key")
  local mappings = {
    ["<leader>gd"] = { ":DiffviewOpen<CR>", "Git diff" },
    ["<leader>gh"] = { ":DiffviewFileHistory %<CR>", "Show file history" },
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


M.trouble = function()
  local wk = require("which-key")
  local mappings = {
    ["<leader>ldd"] = { ":TroubleToggle<CR>", "Open Diagnostic List" },
  }
  wk.register(mappings)
end

M.noice = function()
  local wk = require("which-key")
  local mappings = {
    ["<leader><Esc>"] = { ":Noice dismiss<CR>", "Dismiss noice" },
    ["<leader>fn"] = { ":Noice telescope<CR>", "Find noice" },
  }
  wk.register(mappings)
end

M.project = function()
  local wk = require("which-key")
  local mappings = {
    ["<leader>fp"] = { ":Telescope projects<CR>", "Find Projects" },
  }
  wk.register(mappings)
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

return M
