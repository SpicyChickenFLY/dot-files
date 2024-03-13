local M = {}

-- Wrapper set `silent` to true by default.
local function wrap(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  opts.silent = true
  return { lhs, rhs, mode = mode, opts }
end
local function map_wrap(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  opts.silent = true
  vim.keymap.set(mode or 'n', lhs, rhs, opts)
end
local function map_buf_wrap(bufnr, mode, lhs, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  opts.silent = true
  opts.buffer = bufnr
  vim.keymap.set(mode or 'n', lhs, rhs, opts)
end

M.general = function()
  map_wrap({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", "Escape and clear hlsearch")
  map_wrap("n", "<C-h>", "<C-w>h", "Go to left window", { remap = true })
  map_wrap("n", "<C-j>", "<C-w>j", "Go to lower window", { remap = true })
  map_wrap("n", "<C-k>", "<C-w>k", "Go to upper window", { remap = true })
  map_wrap("n", "<C-l>", "<C-w>l", "Go to right window", { remap = true })
  map_wrap("n", "-", ":resize -2<cr>", "Decrease window height")
  map_wrap("n", "=", ":resize +2<cr>", "Increase window height")
  map_wrap("n", "_", ":vertical resize -2<cr>", "Decrease window width")
  map_wrap("n", "+", ":vertical resize +2<cr>", "Increase window width")
  map_wrap("n", "<leader>w", ":w<CR>", "Save current buffer")
  map_wrap("n", "<leader>W", ":w !sudo tee %<CR>", "Save current buffer with super priv")
  map_wrap("n", "<leader>d", ":bd<CR>", "Close current buffer")
  map_wrap("n", "<leader>q", ":q<CR>", "Close current window")
  map_wrap("n", "<leader>Q", ":qa<CR>", "Close all windows")
  map_wrap("i", "jj", "<ESC>")
  map_wrap("i", "jk", "<ESC>:w<CR>")
  map_wrap("i", "<C-a>", "<Home>")
  map_wrap("i", "<C-e>", "<End>")
  map_wrap("i", "<C-b>", "<Left>")
  map_wrap("i", "<C-f>", "<Right>")
  map_wrap("i", "<C-n>", "<Down>")
  map_wrap("i", "<C-p>", "<Up>")
  map_wrap("i", "<C-v>", "<ESC>pi")
  map_wrap("n", "gl",
    ':echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . "> trans<" . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>')
  map_wrap("n", "gL", ':Inspect!<CR>')
  map_wrap("n", '<leader>pc', ":Lazy check<CR>", "Check update")
  map_wrap("n", '<leader>ps', ":Lazy sync<CR>", "Sync update")
  map_wrap("n", '<leader>pp', ":Lazy home<CR>", "Open list")
end

-------------- UI stuff --------------
M.bufferline = {
  wrap("n", "H", ":BufferLineCyclePrev<CR>", "Prev buffer"),
  wrap("n", "L", ":BufferLineCycleNext<CR>", "Next buffer"), }
M.ufo = {
  wrap("n", "zR", ":lua require'ufo'.openAllFolds()<CR>", "open all folds"),
  wrap("n", "zM", ":lua require'ufo'.closeAllFolds()<CR>", "close all folds"),
  wrap("n", "zr", ":lua require'ufo'.openFoldsExceptKinds()<CR>", "open next fold level"),
  wrap("n", "zm", ":lua require'ufo'.closeFoldsWith()<CR>", "close next fold level"),
  wrap("n", "z1", ":lua require'ufo'.closeFoldsWith(1)<CR>", "close fold level 1"),
  wrap("n", "z2", ":lua require'ufo'.closeFoldsWith(2)<CR>", "close fold level 2"),
  wrap("n", "z3", ":lua require'ufo'.closeFoldsWith(3)<CR>", "close fold level 3"),
  wrap("n", "z4", ":lua require'ufo'.closeFoldsWith(4)<CR>", "close fold level 4"), }
M.mini_indent_mappings = {
  object_scope = 'ii',             -- Textobjects Inside
  object_scope_with_border = 'ai', -- Textobjects Around
  -- Motions (jump to respective border line; if not present - body line)
  goto_top = '[i',
  goto_bottom = ']i',
}

-------------- Sidebar tools --------------
M.spectre = {
  wrap("n", "<leader>rr", function() require("spectre").open() end, "open panel"),
  wrap("n", "<leader>rw", function() require("spectre").open_visual({ select_word = true }) end, "search current word"),
  wrap("n", "<leader>rf", function() require("spectre").open_file_search() end, "search in file"), }
M.outline = { wrap("n", "<leader>lo", ':Outline<CR>', "toggle outline"), }
M.neotest = {
  wrap("n", "<leader>tt", ":lua require('neotest').summary.open()<CR>", "open output panel"),
  wrap("n", "<leader>to", ":lua require('neotest').output.open({ enter = true })<CR>", "open output"),
  wrap("n", "<leader>tO", ":lua require('neotest').output_panel.open()<CR>", "open output panel"),
  wrap("n", "<leader>tr", ":lua require'neotest'.run.run()<CR>", "Run nearest test"),
  wrap("n", "<leader>tf", ":lua require'neotest'.run.run(vim.fn.expand('%'))<CR>", "Test current file"),
  wrap("n", "<leader>td", ":lua require'neotest'.run.run(vim.fn.expand('%:ph'))<CR>", "Test current dir"),
  wrap("n", "<leader>tg", ":lua require'neotest'.run.run(vim.fn.getcwd())<CR>", "Test root dir"),
  wrap("n", "<leader>tD", ":lua require'neotest'.run.run({strategy = 'dap'})<CR>", "Debug nearest test"), }

-------------- Coding --------------
M.mason = { wrap("n", "<leader>lm", ":Mason<CR>", "Open Manager(Mason)"), }
M.flutter_tools = function() map_wrap("n", "<leader>lc", ":Telescope flutter commands<CR>", "Flutter commands") end
M.sqls = function(bufnr)
  local function _map(mode, l, r, desc)
    vim.keymap.set(mode, l, r, { buffer = bufnr, desc })
  end
  _map('n', '<leader>xx', ":SqlsExecuteQuery<CR>", 'Stage hunk')
  _map('n', '<leader>xX', ":SqlsExecuteQueryVertical<CR>", 'Reset hunk')
  _map('v', '<leader>xx', "<Plug>(sqls-execute-query)", 'Stage hunk')
  _map('v', '<leader>xX', "<Plug>(sqls-execute-query-vertical)", 'Reset hunk')
end
M.lspconfig = {
  wrap("n", "K", vim.lsp.buf.hover, "show hover"),
  wrap("n", "gd", vim.lsp.buf.definition, "goto definition"),
  wrap("n", "gD", vim.lsp.buf.declaration, "goto declaration"),
  wrap("n", "gt", vim.lsp.buf.type_definition, "goto definition type"),
  wrap("n", "gr", vim.lsp.buf.references, "goto references"),
  wrap("n", "gi", vim.lsp.buf.implementation, "goto implementation"),
  wrap("n", "gs", vim.lsp.buf.document_symbol, "show document symbol "),
  wrap("n", "gh", vim.lsp.buf.signature_help, "show signature help"),
  wrap("n", "<leader>la", vim.lsp.buf.code_action, "code action"),
  wrap("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "formatting"),
  wrap("n", "<leader>ll", ":LspLog<CR>", "Lsp server log"),
  wrap("n", "<leader>li", ":LspInfo<CR>", "Lsp server Info"),
  wrap("n", "<leader>lr", vim.lsp.buf.rename, "rename"),
  wrap("n", "<leader>ldf", vim.diagnostic.open_float, "Diagnostic setloclist"),
  wrap("n", "<leader>ldq", vim.diagnostic.setloclist, "Diagnostic setloclist"),
  wrap("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, "Add workspace folder"),
  wrap("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder"),
  wrap("n", "<leader>lwl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
    "List workspace folders"),

  wrap("n", "[d", function() vim.diagnostic.goto_prev { float = { border = "rounded" } } end, "Prev diagnostic"),
  wrap("n", "]d", function() vim.diagnostic.goto_next { float = { border = "rounded" } } end, "Next diagnostic"),
}
M.dap = {
  wrap("n", "<leader>Db", ":lua require'dap'.step_back()<CR>", "step back"),
  wrap("n", "<leader>DB", ":lua require'dap'.toggle_breakpoint()<CR>", "toggle breakpoint"),
  wrap("n", "<leader>Dc", ":lua require'dap'.continue()<CR>", "continue"),
  wrap("n", "<leader>DD", ":lua require'dapui'.toggle()<CR>", "Toggle UI"),
  wrap("n", "<leader>Dr", ":lua require'dap'.run_to_cursor()<CR>", "run to cursor"),
  wrap("n", "<leader>Dd", ":lua require'dap'.disconnect()<CR>", "disconnect"),
  wrap("n", "<leader>Dg", ":lua require'dap'.session()<CR>", "get session"),
  wrap("n", "<leader>Di", ":lua require'dap'.step_into()<CR>", "step into"),
  wrap("n", "<leader>Dl", ":lua require'dap'.repl.toggle()<CR>", "toggle repl"),
  wrap("n", "<leader>Do", ":lua require'dap'.step_over()<CR>", "step over"),
  wrap("n", "<leader>Du", ":lua require'dap'.step_out()<CR>", "step out"),
  wrap("n", "<leader>Dp", ":lua require'dap'.pause()<CR>", "pause"),
  wrap("n", "<leader>Ds", ":lua require'dap'.continue()<CR>", "start"),
  wrap("n", "<leader>Dq", ":lua require'dap'.close()<CR>", "quit"),
  wrap("n", "<F5>", ":lua require'dap'.continue()<CR>", ""),
  wrap("n", "<S-F5>", ":lua require'dap'.run_to_cursor()<CR>", ""),
  wrap("n", "<F9>", ":lua require'dap'.toggle_breakpoint()<CR>", ""),
  wrap("n", "<S-F9>", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", ""),
  wrap("n", "<S-F8>", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", ""),
  wrap("n", "<F10>", ":lua require'dap'.step_over()<CR>", ""),
  wrap("n", "<F11>", ":lua require'dap'.step_into()<CR>", ""),
  wrap("n", "<S-F11>", ":lua require'dap'.step_out()<CR>", ""),
  -- wrap("n", "",  ":lua require'dap'.pause()<CR>" , ""),
  wrap("n", "<F12>", ":lua require'dap'.run_last()<CR>", ""),
  wrap("n", "<S-F12>", ":lua require'dap'.terminate()<CR>", ""),
  -- wrap("n", "",     ":lua require'dap'.repl.toggle()<CR>", "" ),
}
M.cmp_mapping = function(cmp, snippet, has_words_before)
  return {
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-h>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
    ['<C-l>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
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
  wrap("n", "<leader>hh", "<Plug>RestNvim", "run the request under the cursor"),
  wrap("n", "<leader>hp", "<Plug>RestNvimPreview", "preview the request cURL command"),
  wrap("n", "<leader>hl", "<Plug>RestNvimLast", "re-run the last request"), }
-------------- Finder --------------
M.telescope = {
  wrap("n", "<leader>fa", ":Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all"),
  wrap("n", "<leader>fc", ":Telescope commands<CR>", "Commands"),
  wrap("n", "<leader>fe", ":Telescope emoji<CR>", "Checkout branch"),
  wrap("n", "<leader>ff", ":Telescope find_files<CR>", "Find File"),
  wrap("n", "<leader>fh", ":Telescope help_tags<CR>", "Find Help"),
  wrap("n", "<leader>fH", ":Telescope highlights<CR>", "Find highlight groups"),
  wrap("n", "<leader>fM", ":Telescope man_pages<CR>", "Man Pages"),
  wrap("n", "<leader>fl", ":Telescope live_grep<CR>", "Text"),
  wrap("n", "<leader>fk", ":Telescope keymaps<CR>", "Keymaps"),
  wrap("n", "<leader>fo", ":Telescope oldfiles<CR>", "Find oldfiles"),
  wrap("n", "<leader>ft", ":lua require('telescope.builtin').colorscheme {enable_preview=true}<CR>",
    "Colorscheme with Preview"),
  wrap("n", "<leader>fz", ":Telescope current_buffer_fuzzy_find<CR>", "Find in current buffer"),
  wrap("n", "<leader>gc", ":Telescope git_commits<CR>", "Open changed file"),
  wrap("n", "<leader>gg", ":Telescope git_status<CR>", "Open changed file"),
}
M.sessionlens = { wrap("n", "<leader>sf", ":SearchSession<CR>", "Find Session"), }
M.trouble = { wrap("n", "<leader>ldd", ":TroubleToggle<CR>", "Open Diagnostic List"), }

-------------- Tools --------------
M.autosession = {
  wrap("n", "<leader>ss", ":SessionSave<CR>", "save session"),
  wrap("n", "<leader>sl", ":SessionRestore<CR>", "load session"), }
M.diffview = {
  wrap("n", "<leader>gd", ":DiffviewOpen<CR>", "Git diff"),
  wrap("n", "<leader>gh", ":DiffviewFileHistory %<CR>", "Show file history"), }
M.flash = {
  wrap({ "n", "x", "o" }, "s", function() require("flash").jump() end, "Flash"),
  wrap({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, "Flash Treesitter"),
  wrap("o", "r", function() require("flash").remote() end, "Remote Flash"),
  wrap({ "o", "x" }, "R", function() require("flash").treesitter_search() end, "Treesitter Search"),
  wrap({ "c" }, "<c-s>", function() require("flash").toggle() end, "Toggle Flash Search"), }
M.floaterm = {
  wrap("n", "<C-`>", ":FloatermToggle<CR>"),
  wrap("n", "<leader>`", ":FloatermNew<CR>", "Open shell"),
  wrap("n", "<leader>ef", ":FloatermNew ranger<CR>", "Open ranger"),
  wrap("n", "<leader>ee", ":FloatermNew ranger $pwd<CR>", "Open ranger"),
  wrap("n", "<leader>gl", ":FloatermNew lazygit<CR>", "Open Lazygit"),
  wrap("t", "<C-Tab>", [[<C-\><C-n>:FloatermNext<CR>]]),
  wrap("t", "<C-S-Tab>", [[<C-\><C-n>:FloatermPrev<CR>]]),
  wrap("t", "<C-`>", [[<C-\><C-n>:FloatermToggle<CR>]]),
  wrap("t", "<C-\\>", [[<C-\><C-n>]]), }
M.gitsigns = function(bufnr, gs)
  map_buf_wrap(bufnr, 'n', ']c', gs.next_hunk, 'Next hunk')
  map_buf_wrap(bufnr, 'n', '[c', gs.prev_hunk, 'Prev hunk')
  map_buf_wrap(bufnr, 'n', '<leader>gs', gs.stage_hunk, 'Stage hunk')
  map_buf_wrap(bufnr, 'n', '<leader>gr', gs.reset_hunk, 'Reset hunk')
  map_buf_wrap(bufnr, 'n', '<leader>gp', gs.preview_hunk, 'Preview hunk')
  map_buf_wrap(bufnr, 'n', '<leader>gb', gs.blame_line, 'Blame line')
  map_buf_wrap(bufnr, 'n', '<leader>gB', function() gs.blame_line { full = true } end, 'Blame line with detail')
  -- NOTE: dont need buffer operation
  -- map_buf_wrap(bufnr, 'n', '<leader>gS', gs.stage_buffer)
  -- map_buf_wrap(bufnr, 'n', '<leader>gu', gs.undo_stage_hunk)
  -- map_buf_wrap(bufnr, 'n', '<leader>gR', gs.reset_buffer)
  -- NOTE: will be replaced by diffview.nvim
  -- map_buf_wrap(bufnr, 'n', '<leader>gd', gs.diffthis)
  -- map_buf_wrap(bufnr, 'n', '<leader>gD', function() gs.diffthis('~') end)
  -- map_buf_wrap(bufnr, 'n', '<leader>gt', gs.toggle_deleted)
  map_buf_wrap(bufnr, 'v', '<leader>gs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
    'Stage hunk')
  map_buf_wrap(bufnr, 'v', '<leader>gr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
    'Reset hunk')
  map_buf_wrap(bufnr, { 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
end

return M
