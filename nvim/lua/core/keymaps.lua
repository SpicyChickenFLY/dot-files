-- Wrapper around vim.keymap.set that will
-- not create a keymap if a lazy key handler exists.
-- It will also set `silent` to true by default.

local M = {}

M.general = function()
  local function map(mode, lhs, rhs, opts)
    local modes = type(mode) == "string" and { mode } or mode

    -- do not create the keymap if a lazy keys handler exists
    if #modes > 0 then
      opts = opts or {}
      opts.silent = true
      if opts.remap and not vim.g.vscode then opts.remap = nil end
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

  -- Show the syntax highlight group under cursor
  map("n", "gl", '<cmd>echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . "> trans<" . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>')
  map("n", "gL", '<cmd>Inspect!<CR>')

  map("n", '<leader>pc', ":Lazy check<CR>", { desc = "Check update" })
  map("n", '<leader>ps', ":Lazy sync<CR>", { desc = "Sync update" })
  map("n", '<leader>pp', ":Lazy home<CR>", { desc = "Open list" })
end

-------------- UI stuff --------------
M.bufferline = {
  { "H", ":BufferLineCyclePrev<CR>", desc = "Prev buffer", silent = true },
  { "L", ":BufferLineCycleNext<CR>", desc = "Next buffer", silent = true },
}
M.noice = {
  { "<leader><Esc>", ":Noice dismiss<CR>",   silent = true, desc = "Dismiss noice" },
  { "<leader>fn",    ":Noice telescope<CR>", silent = true, desc = "Find noice" },
}
M.ufo = {
  { "zR", ":lua require'ufo'.openAllFolds()<CR>",         silent = true, desc = "open all folds" },
  { "zM", ":lua require'ufo'.closeAllFolds()<CR>",        silent = true, desc = "close all folds" },
  { "zr", ":lua require'ufo'.openFoldsExceptKinds()<CR>", silent = true, desc = "open next fold level" },
  { "zm", ":lua require'ufo'.closeFoldsWith()<CR>",       silent = true, desc = "close next fold level" },
  { "z1", ":lua require'ufo'.closeFoldsWith(1)<CR>",      silent = true, desc = "close fold level 1" },
  { "z2", ":lua require'ufo'.closeFoldsWith(2)<CR>",      silent = true, desc = "close fold level 2" },
  { "z3", ":lua require'ufo'.closeFoldsWith(3)<CR>",      silent = true, desc = "close fold level 3" },
  { "z4", ":lua require'ufo'.closeFoldsWith(4)<CR>",      silent = true, desc = "close fold level 4" },
}
M.mini_indent_mappings = {
  -- Textobjects
  object_scope = 'ii',
  object_scope_with_border = 'ai',
  -- Motions (jump to respective border line; if not present - body line)
  goto_top = '[i',
  goto_bottom = ']i',
}
-------------- Sidebar tools --------------
M.neotree = {
  { "<leader>ee", ":Neotree<CR>",             silent = true, desc = "open panel" },
  { "<leader>ef", ":Neotree reveal=true<CR>", silent = true, desc = "show current file" },
}
M.spectre = {
  { "<leader>rr", function() require("spectre").open() end,                              silent = true, desc = "open panel" },
  { "<leader>rw", function() require("spectre").open_visual({ select_word = true }) end, silent = true, desc = "search current word" },
  { "<leader>rf", function() require("spectre").open_file_search() end,                  silent = true, desc = "search in file" },
}
M.outline = { { "<leader>lo", ':Outline<CR>', silent = true, desc = "toggle outline" }, }
M.neotest = {
  { "<leader>tt", ":lua require('neotest').summary.open()<CR>",                silent = true, desc = "open output panel" },
  { "<leader>to", ":lua require('neotest').output.open({ enter = true })<CR>", silent = true, desc = "open output" },
  { "<leader>tO", ":lua require('neotest').output_panel.open()<CR>",           silent = true, desc = "open output panel" },
  { "<leader>tr", ":lua require'neotest'.run.run()<CR>",                       silent = true, desc = "Run nearest test" },
  { "<leader>tf", ":lua require'neotest'.run.run(vim.fn.expand('%'))<CR>",     silent = true, desc = "Test current file" },
  { "<leader>td", ":lua require'neotest'.run.run(vim.fn.expand('%:ph'))<CR>",  silent = true, desc = "Test current dir" },
  { "<leader>tg", ":lua require'neotest'.run.run(vim.fn.getcwd())<CR>",        silent = true, desc = "Test root dir" },
  { "<leader>tD", ":lua require'neotest'.run.run({strategy = 'dap'})<CR>",     silent = true, desc = "Debug nearest test" },
}
-------------- Coding --------------
M.mason = {
  { "<leader>lm", ":Mason<CR>", silent = true, desc = "Open Manager(Mason)" },
}
M.flutter_tools = function()
  local function _map(mode, l, r, desc)
    vim.keymap.set(mode, l, r, { silent = true, desc = desc })
  end
  _map("n", "<leader>lc", ":Telescope flutter commands<CR>" , "Flutter commands")
end
M.sqls = function(bufnr)
  local function _map(mode, l, r, desc)
    vim.keymap.set(mode, l, r, { buffer = bufnr, silent = true, desc = desc })
  end
  _map('n', '<leader>xx', ":SqlsExecuteQuery<CR>", 'Stage hunk')
  _map('n', '<leader>xX', ":SqlsExecuteQueryVertical<CR>", 'Reset hunk')
  _map('v', '<leader>xx', "<Plug>(sqls-execute-query)", 'Stage hunk')
  _map('v', '<leader>xX', "<Plug>(sqls-execute-query-vertical)", 'Reset hunk')
end
M.lspconfig = {
  { "K",           vim.lsp.buf.hover,                                                          silent = true, desc = "show hover" },

  { "gd",          vim.lsp.buf.definition,                                                     silent = true, desc = "goto definition" },
  { "gD",          vim.lsp.buf.declaration,                                                    silent = true, desc = "goto declaration" },
  { "gt",          vim.lsp.buf.type_definition,                                                silent = true, desc = "goto definition type", },
  { "gr",          vim.lsp.buf.references,                                                     silent = true, desc = "goto references" },
  { "gi",          vim.lsp.buf.implementation,                                                 silent = true, desc = "goto implementation" },
  { "gs",          vim.lsp.buf.document_symbol,                                                silent = true, desc = "show document symbol " },
  { "gh",          vim.lsp.buf.signature_help,                                                 silent = true, desc = "show signature help" },

  { "<leader>la",  vim.lsp.buf.code_action,                                                    silent = true, desc = "code action" },
  { "<leader>lf",  function() vim.lsp.buf.format({ async = true }) end,                        silent = true, desc = "formatting" },
  { "<leader>ll",  ":LspLog<CR>",                                                              silent = true, desc = "Lsp server log" },
  { "<leader>li",  ":LspInfo<CR>",                                                             silent = true, desc = "Lsp server Info" },
  { "<leader>lr",  vim.lsp.buf.rename,                                                         silent = true, desc = "rename" },

  { "<leader>ldf", vim.diagnostic.open_float,                                                  silent = true, desc = "Diagnostic setloclist", },
  { "<leader>ldq", vim.diagnostic.setloclist,                                                  silent = true, desc = "Diagnostic setloclist", },

  { "<leader>lwa", vim.lsp.buf.add_workspace_folder,                                           silent = true, desc = "Add workspace folder" },
  { "<leader>lwr", vim.lsp.buf.remove_workspace_folder,                                        silent = true, desc = "Remove workspace folder" },
  { "<leader>lwl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,    silent = true, desc = "List workspace folders" },

  { "[d",          function() vim.diagnostic.goto_prev { float = { border = "rounded" } } end, silent = true, desc = "Prev diagnostic" },
  { "]d",          function() vim.diagnostic.goto_next { float = { border = "rounded" } } end, silent = true, desc = "Next diagnostic" },
}
M.dap = {
  { "<leader>Db", ":lua require'dap'.step_back()<CR>",                                                   silent = true, desc = "step back" },
  { "<leader>DB", ":lua require'dap'.toggle_breakpoint()<CR>",                                           silent = true, desc = "toggle breakpoint" },
  { "<leader>Dc", ":lua require'dap'.continue()<CR>",                                                    silent = true, desc = "continue" },
  { "<leader>DD", ":lua require'dapui'.toggle()<CR>",                                                    silent = true, desc = "Toggle UI" },
  { "<leader>Dr", ":lua require'dap'.run_to_cursor()<CR>",                                               silent = true, desc = "run to cursor" },
  { "<leader>Dd", ":lua require'dap'.disconnect()<CR>",                                                  silent = true, desc = "disconnect" },
  { "<leader>Dg", ":lua require'dap'.session()<CR>",                                                     silent = true, desc = "get session" },
  { "<leader>Di", ":lua require'dap'.step_into()<CR>",                                                   silent = true, desc = "step into" },
  { "<leader>Dl", ":lua require'dap'.repl.toggle()<CR>",                                                 silent = true, desc = "toggle repl" },
  { "<leader>Do", ":lua require'dap'.step_over()<CR>",                                                   silent = true, desc = "step over" },
  { "<leader>Du", ":lua require'dap'.step_out()<CR>",                                                    silent = true, desc = "step out" },
  { "<leader>Dp", ":lua require'dap'.pause()<CR>",                                                       silent = true, desc = "pause" },
  { "<leader>Ds", ":lua require'dap'.continue()<CR>",                                                    silent = true, desc = "start" },
  { "<leader>Dq", ":lua require'dap'.close()<CR>",                                                       silent = true, desc = "quit" },

  -- F-map alias DAP keymaps
  { "<F5>",       ":lua require'dap'.continue()<CR>",                                                    silent = true },
  { "<S-F5>",     ":lua require'dap'.run_to_cursor()<CR>",                                               silent = true },
  { "<F9>",       ":lua require'dap'.toggle_breakpoint()<CR>",                                           silent = true },
  { "<S-F9>",     ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",        silent = true },
  { "<S-F8>",     ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", silent = true },
  { "<F10>",      ":lua require'dap'.step_over()<CR>",                                                   silent = true },
  { "<F11>",      ":lua require'dap'.step_into()<CR>",                                                   silent = true },
  { "<S-F11>",    ":lua require'dap'.step_out()<CR>",                                                    silent = true },
  -- { "",  ":lua require'dap'.pause()<CR>" )
  { "<F12>",      ":lua require'dap'.run_last()<CR>",                                                    silent = true },
  { "<S-F12>",    ":lua require'dap'.terminate()<CR>",                                                   silent = true },
  -- { "",     ":lua require'dap'.repl.toggle()<CR>", silent = true },
}
M.cmp_mapping = function(cmp, snippet, has_words_before)
  return {
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-h>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<C-l>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ['<C-j>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif snippet.expand_or_jumpable() then
        snippet.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 'c', 's', }
    ),
    ['<C-k>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif snippet.jumpable(-1) then
        snippet.jump(-1)
      else
        fallback()
      end
    end, { 'i', 'c', 's', }
    ),
  }
end
M.rest = {
  { "<leader>hh", "<Plug>RestNvim",        silent = true, desc = "run the request under the cursor" },
  { "<leader>hp", "<Plug>RestNvimPreview", silent = true, desc = "preview the request cURL command" },
  { "<leader>hl", "<Plug>RestNvimLast",    silent = true, desc = "re-run the last request" },
}
-------------- Finder --------------
M.telescope = {
  { "<leader>fa", ":Telescope find_files follow=true no_ignore=true hidden=true <CR>",       silent = true, desc = "Find all" },
  { "<leader>fc", ":Telescope commands<CR>",                                                 silent = true, desc = "Commands" },
  { "<leader>fe", ":Telescope emoji<CR>",                                                    silent = true, desc = "Checkout branch" },
  { "<leader>ff", ":Telescope find_files<CR>",                                               silent = true, desc = "Find File" },
  { "<leader>fh", ":Telescope help_tags<CR>",                                                silent = true, desc = "Find Help" },
  { "<leader>fH", ":Telescope highlights<CR>",                                               silent = true, desc = "Find highlight groups" },
  { "<leader>fM", ":Telescope man_pages<CR>",                                                silent = true, desc = "Man Pages" },
  { "<leader>fl", ":Telescope live_grep<CR>",                                                silent = true, desc = "Text" },
  { "<leader>fk", ":Telescope keymaps<CR>",                                                  silent = true, desc = "Keymaps" },
  { "<leader>fo", ":Telescope oldfiles<CR>",                                                 silent = true, desc = "Find oldfiles" },
  { "<leader>ft", ":lua require('telescope.builtin').colorscheme {enable_preview=true}<CR>", silent = true, desc = "Colorscheme with Preview", },
  { "<leader>fz", ":Telescope current_buffer_fuzzy_find<CR>",                                silent = true, desc = "Find in current buffer" },

  { "<leader>gc", ":Telescope git_commits<CR>",                                              silent = true, desc = "Open changed file" },
  { "<leader>gg", ":Telescope git_status<CR>",                                               silent = true, desc = "Open changed file" },
}
M.sessionlens = { { "<leader>sf", ":SearchSession<CR>", silent = true, desc = "Find Session" }, }
M.trouble = { { "<leader>ldd", ":TroubleToggle<CR>", silent = true, desc = "Open Diagnostic List" }, }


-------------- Tools --------------
M.autosession = {
  { "<leader>ss", ":SessionSave<CR>",    "save session" },
  { "<leader>sl", ":SessionRestore<CR>", "load session" },
}
M.diffview = {
  { "<leader>gd", ":DiffviewOpen<CR>",          silent = true, desc = "Git diff" },
  { "<leader>gh", ":DiffviewFileHistory %<CR>", silent = true, desc = "Show file history" },
}
M.flash = {
  { "s",     mode = { "n", "x", "o" }, ":lua require('flash').jump()<CR>",              silent = true, desc = "Flash" },
  { "S",     mode = { "n", "x", "o" }, ":lua require('flash').treesitter()<CR>",        silent = true, desc = "Flash Treesitter" },
  { "r",     mode = "o",               ":lua require('flash').remote()<CR>",            silent = true, desc = "Remote Flash" },
  { "R",     mode = { "o", "x" },      ":lua require('flash').treesitter_search()<CR>", silent = true, desc = "Treesitter Search" },
  { "<c-s>", mode = { "c" },           ":lua require('flash').toggle()<CR>",            silent = true, desc = "Toggle Flash Search" },
}
M.floaterm = {
  { "<C-\\>",     ":FloatermToggle<CR>",      silent = true },
  { '<leader>er', ":FloatermNew ranger<CR>",  silent = true, desc = "Open ranger" },
  { '<leader>gl', ":FloatermNew lazygit<CR>", silent = true, desc = "Open ranger" },
}
M.floaterm_func = function()
  vim.keymap.set("t", "<C-\\>", [[<C-\><C-n>:FloatermToggle<CR>]], { silent = true })
end
M.gitsigns = function(bufnr, gs)
  local function map(mode, l, r, desc)
    vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
  end

  map('n', ']c', gs.next_hunk, 'Next hunk')
  map('n', '[c', gs.prev_hunk, 'Prev hunk')

  map('n', '<leader>gs', gs.stage_hunk, 'Stage hunk')
  map('n', '<leader>gr', gs.reset_hunk, 'Reset hunk')
  map('n', '<leader>gp', gs.preview_hunk, 'Preview hunk')
  map('n', '<leader>gb', gs.blame_line, 'Blame line')
  map('n', '<leader>gB', function() gs.blame_line { full = true } end, 'Blame line with detail')

  -- NOTE: dont need buffer operation
  -- map('n', '<leader>gS', gs.stage_buffer)
  -- map('n', '<leader>gu', gs.undo_stage_hunk)
  -- map('n', '<leader>gR', gs.reset_buffer)
  -- NOTE: will be replaced by diffview.nvim
  -- map('n', '<leader>gd', gs.diffthis)
  -- map('n', '<leader>gD', function() gs.diffthis('~') end)
  -- map('n', '<leader>gt', gs.toggle_deleted)

  map('v', '<leader>gs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, 'Stage hunk')
  map('v', '<leader>gr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, 'Reset hunk')

  map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
end

return M
