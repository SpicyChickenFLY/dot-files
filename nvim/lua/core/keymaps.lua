local M = {}

-- Wrapper set `silent` to true by default.
local function wrap_lazy(mode, lhs, rhs, desc, opts)
  return { lhs, rhs, mode = mode, desc = desc, silent = true, opts }
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
  map_wrap("n", "<leader>cc", ":call setreg('+', expand('%:.') . ':' . line('.'))<CR>",
    "Copy file/line position to clipboard")
  map_wrap("n", "<leader>cp", ":e <C-r>+<CR>", "jump position according register +")
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
    ':echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . "> trans<" . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>',
    "Show highlight")
  map_wrap("n", "gL", ':Inspect!<CR>')
  map_wrap("n", '<leader>pc', ":Lazy check<CR>", "Check update")
  map_wrap("n", '<leader>ps', ":Lazy sync<CR>", "Sync update")
  map_wrap("n", '<leader>pp', ":Lazy home<CR>", "Open list")
  map_wrap("c", '<c-j>', "", "disable default <c-j> -> <CR> in cmdline mode")
end

-------------- UI stuff --------------
M.bufferline = {
  wrap_lazy("n", "H", ":BufferLineCyclePrev<CR>", "Prev buffer"),
  wrap_lazy("n", "L", ":BufferLineCycleNext<CR>", "Next buffer"), }
M.ufo = {
  wrap_lazy("n", "zR", ":lua require'ufo'.openAllFolds()<CR>", "open all folds"),
  wrap_lazy("n", "zM", ":lua require'ufo'.closeAllFolds()<CR>", "close all folds"),
  wrap_lazy("n", "zr", ":lua require'ufo'.openFoldsExceptKinds()<CR>", "open next fold level"),
  wrap_lazy("n", "zm", ":lua require'ufo'.closeFoldsWith()<CR>", "close next fold level"),
  wrap_lazy("n", "z1", ":lua require'ufo'.closeFoldsWith(1)<CR>", "close fold level 1"),
  wrap_lazy("n", "z2", ":lua require'ufo'.closeFoldsWith(2)<CR>", "close fold level 2"),
  wrap_lazy("n", "z3", ":lua require'ufo'.closeFoldsWith(3)<CR>", "close fold level 3"),
  wrap_lazy("n", "z4", ":lua require'ufo'.closeFoldsWith(4)<CR>", "close fold level 4"), }
M.mini_indent_mappings = {
  object_scope = 'ii',             -- Textobjects Inside
  object_scope_with_border = 'ai', -- Textobjects Around
  goto_top = '[i',                 -- jump Start of Textobjects
  goto_bottom = ']i',              -- jump End of Textobjects
}

-------------- Sidebar tools --------------
M.spectre = {
  wrap_lazy("n", "<leader>rr", function() require("spectre").open() end, "open panel"),
  wrap_lazy("n", "<leader>rw", function() require("spectre").open_visual({ select_word = true }) end,
    "search current word"),
  wrap_lazy("n", "<leader>rf", function() require("spectre").open_file_search() end, "search in file"), }
M.outline = { wrap_lazy("n", "<leader>lo", ':Outline<CR>', "toggle outline"), }
M.neotest = {
  wrap_lazy("n", "<leader>tt", ":lua require('neotest').summary.open()<CR>", "open output panel"),
  wrap_lazy("n", "<leader>to", ":lua require('neotest').output.open({ enter = true })<CR>", "open output"),
  wrap_lazy("n", "<leader>tO", ":lua require('neotest').output_panel.open()<CR>", "open output panel"),
  wrap_lazy("n", "<leader>tr", ":lua require'neotest'.run.run()<CR>", "Run nearest test"),
  wrap_lazy("n", "<leader>tf", ":lua require'neotest'.run.run(vim.fn.expand('%'))<CR>", "Test current file"),
  wrap_lazy("n", "<leader>td", ":lua require'neotest'.run.run(vim.fn.expand('%:ph'))<CR>", "Test current dir"),
  wrap_lazy("n", "<leader>tg", ":lua require'neotest'.run.run(vim.fn.getcwd())<CR>", "Test root dir"),
  wrap_lazy("n", "<leader>tD", ":lua require'neotest'.run.run({strategy = 'dap'})<CR>", "Debug nearest test"), }

-------------- Coding --------------
M.mason = { wrap_lazy("n", "<leader>lm", ":Mason<CR>", "Open Manager(Mason)"), }
M.lspconfig = {
  wrap_lazy("n", "K", vim.lsp.buf.hover, "show hover"),
  wrap_lazy("n", "gd", ":Telescope lsp_definitions<CR>", "goto definition"),
  wrap_lazy("n", "gD", vim.lsp.buf.declaration, "goto declaration"),
  wrap_lazy("n", "gt", ":Telescope lsp_type_definitions<CR>", "goto definition type"),
  wrap_lazy("n", "gr", ":Telescope lsp_references<CR>", "goto references"),
  wrap_lazy("n", "gi", ":Telescope lsp_implementations<CR>", "goto implementation"),
  wrap_lazy("n", "gs", ":Telescope lsp_document_symbols<CR>", "show document symbol "),
  wrap_lazy("n", "gh", vim.lsp.buf.signature_help, "show signature help"),
  wrap_lazy("n", "<leader>la", vim.lsp.buf.code_action, "code action"),
  wrap_lazy("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "formatting"),
  wrap_lazy("n", "<leader>ll", ":LspLog<CR>", "Lsp server log"),
  wrap_lazy("n", "<leader>li", ":LspInfo<CR>", "Lsp server Info"),
  wrap_lazy("n", "<leader>lr", vim.lsp.buf.rename, "rename"),
  wrap_lazy("n", "<leader>ld", ":Telescope diagnostics<CR>", "Find diagnostics"),
  wrap_lazy("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, "Add workspace folder"),
  wrap_lazy("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder"),
  wrap_lazy("n", "<leader>lwl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
    "List workspace folders"),

  wrap_lazy("n", "[d", function() vim.diagnostic.goto_prev {} end, "Prev diagnostic"),
  wrap_lazy("n", "]d", function() vim.diagnostic.goto_next {} end, "Next diagnostic"),
  wrap_lazy("n", "[e", function() vim.diagnostic.goto_prev { severity = vim.diagnostic.severity.ERROR } end, "Prev error"),
  wrap_lazy("n", "]e", function() vim.diagnostic.goto_next { severity = vim.diagnostic.severity.ERROR } end, "Next error"),
}
M.dap = {
  wrap_lazy("n", "<leader>Db", ":lua require'dap'.step_back()<CR>", "step back"),
  wrap_lazy("n", "<leader>DB", ":lua require'dap'.toggle_breakpoint()<CR>", "toggle breakpoint"),
  wrap_lazy("n", "<leader>Dc", ":lua require'dap'.continue()<CR>", "continue"),
  wrap_lazy("n", "<leader>DD", ":lua require'dapui'.toggle()<CR>", "Toggle UI"),
  wrap_lazy("n", "<leader>Dr", ":lua require'dap'.run_to_cursor()<CR>", "run to cursor"),
  wrap_lazy("n", "<leader>Dd", ":lua require'dap'.disconnect()<CR>", "disconnect"),
  wrap_lazy("n", "<leader>Dg", ":lua require'dap'.session()<CR>", "get session"),
  wrap_lazy("n", "<leader>Di", ":lua require'dap'.step_into()<CR>", "step into"),
  wrap_lazy("n", "<leader>Dl", ":lua require'dap'.repl.toggle()<CR>", "toggle repl"),
  wrap_lazy("n", "<leader>Do", ":lua require'dap'.step_over()<CR>", "step over"),
  wrap_lazy("n", "<leader>Du", ":lua require'dap'.step_out()<CR>", "step out"),
  wrap_lazy("n", "<leader>Dp", ":lua require'dap'.pause()<CR>", "pause"),
  wrap_lazy("n", "<leader>Ds", ":lua require'dap'.continue()<CR>", "start"),
  wrap_lazy("n", "<leader>Dq", ":lua require'dap'.close()<CR>", "quit"),
  wrap_lazy("n", "<F5>", ":lua require'dap'.continue()<CR>", ""),
  wrap_lazy("n", "<S-F5>", ":lua require'dap'.run_last()<CR>", ""),
  wrap_lazy("n", "<F9>", ":lua require'dap'.toggle_breakpoint()<CR>", ""),
  wrap_lazy("n", "<S-F9>", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", ""),
  wrap_lazy("n", "<S-F8>", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", ""),
  wrap_lazy("n", "<F10>", ":lua require'dap'.step_over()<CR>", ""),
  wrap_lazy("n", "<F22>", ":lua require'dap'.run_to_cursor()<CR>", ""), -- <S-F10>
  wrap_lazy("n", "<F11>", ":lua require'dap'.step_into()<CR>", ""),
  wrap_lazy("n", "<F23>", ":lua require'dap'.step_out()<CR>", ""),      -- <S-F12>
  wrap_lazy("n", "<F12>", ":lua require'dap'.close()<CR>", ""),
  -- wrap("n", "",     ":lua require'dap'.repl.toggle()<CR>", "" ),
}
M.cmp_mapping = function(cmp, snippet, has_words_before)
  return {
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-h>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
    ['<C-n>'] = cmp.mapping(function(fallback) fallback() end, { 'i', 'c', 's', }),
    ['<C-p>'] = cmp.mapping(function(fallback) fallback() end, { 'i', 'c', 's', }),
    ['<C-l>'] = cmp.mapping(function(_)
      if cmp.visible() then
        cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
      else
        cmp.complete()
      end
    end, { 'i', 'c', 's', }),
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
    end, { 'i', 'c', 's', }),
    ['<C-k>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif snippet.jumpable(-1) then
        snippet.jump(-1)
      else
        fallback()
      end
    end, { 'i', 'c', 's', }),
  }
end
M.sqls = function(bufnr)
  map_buf_wrap(bufnr, 'n', '<leader>lc', ":SqlsExecuteQuery<CR>", 'Execute Query')
  map_buf_wrap(bufnr, 'n', '<leader>lc', ":SqlsExecuteQueryVertical<CR>", 'Execute Query vertical')
  map_buf_wrap(bufnr, 'v', '<leader>lc', "<Plug>(sqls-execute-query)", 'Execute Query')
  map_buf_wrap(bufnr, 'v', '<leader>lc', "<Plug>(sqls-execute-query-vertical)", 'Execute Query vertical')
end
M.flutter_tools = function() map_wrap("n", "<leader>lc", ":Telescope flutter commands<CR>", "Flutter commands") end
M.markdown_preview = function() map_wrap("n", "<leader>lc", ":MarkdownPreviewToggle<CR>", "Toggle MarkdownPreview") end
M.rest = {
  wrap_lazy("n", "<leader>lcc", ":Rest run<CR>", "run the request under the cursor"),
  wrap_lazy("n", "<leader>lcl", ":Rest run last<CR>", "run latest request"), }
-------------- Finder --------------
M.telescope = {
  wrap_lazy("n", "<leader>fa", ":Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all"),
  wrap_lazy("n", "<leader>fb", ":Telescope buffers<CR>", "buffer"),
  wrap_lazy("n", "<leader>fc", ":Telescope commands<CR>", "command"),
  wrap_lazy("n", "<leader>fC", ":lua require('telescope.builtin').colorscheme {enable_preview=true}<CR>",
    "colorscheme with Preview"),
  wrap_lazy("n", "<leader>ff", ":Telescope find_files<CR>", "file"),
  wrap_lazy("n", "<leader>fh", ":Telescope help_tags<CR>", "help"),
  wrap_lazy("n", "<leader>fH", ":Telescope highlights<CR>", "Highlight groups"),
  wrap_lazy("n", "<leader>fm", ":Telescope marks <CR>", "Marks"),
  wrap_lazy("n", "<leader>fM", ":Telescope man_pages<CR>", "Man Pages"),
  wrap_lazy("n", "<leader>fl", ":Telescope live_grep<CR>", "Text"),
  wrap_lazy("n", "<leader>fk", ":Telescope keymaps<CR>", "Keymaps"),
  wrap_lazy("n", "<leader>fo", ":Telescope oldfiles<CR>", "Old File"),
  wrap_lazy("n", "<leader>fz", ":Telescope current_buffer_fuzzy_find<CR>", "Find in current buffer"),
  wrap_lazy("n", "<leader>gc", ":Telescope git_commits<CR>", "Open changed file"),
  wrap_lazy("n", "<leader>gg", ":Telescope git_status<CR>", "Open changed file"),
}
M.telescope_mapping = function(actions)
  return {
    i = {
      -- NOTE: default keymaps
      ["<LeftMouse>"] = { actions.mouse_click, type = "action", opts = { expr = true } },
      ["<2-LeftMouse>"] = { actions.double_mouse_click, type = "action", opts = { expr = true } },

      -- ["<C-n>"] = actions.move_selection_next,
      -- ["<C-p>"] = actions.move_selection_previous,

      ["<C-c>"] = actions.close,

      ["<Down>"] = actions.move_selection_next,
      ["<Up>"] = actions.move_selection_previous,

      ["<CR>"] = actions.select_default,
      -- ["<C-x>"] = actions.select_horizontal,
      -- ["<C-v>"] = actions.select_vertical,
      ["<C-t>"] = actions.select_tab,

      -- ["<C-u>"] = actions.preview_scrolling_up,
      -- ["<C-d>"] = actions.preview_scrolling_down,
      -- ["<C-f>"] = actions.preview_scrolling_left,
      -- ["<C-k>"] = actions.preview_scrolling_right,

      ["<PageUp>"] = actions.results_scrolling_up,
      ["<PageDown>"] = actions.results_scrolling_down,
      ["<M-f>"] = actions.results_scrolling_left,
      ["<M-k>"] = actions.results_scrolling_right,

      ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
      ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
      ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
      ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      -- ["<C-l>"] = actions.complete_tag,
      ["<C-/>"] = actions.which_key,
      ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      ["<C-w>"] = { "<c-s-w>", type = "command" },
      ["<C-r><C-w>"] = actions.insert_original_cword,

      -- ["<C-j>"] = actions.nop,

      -- NOTE: custom keymappings
      ["<C-n>"] = false,
      ["<C-p>"] = false,
      ["<C-x>"] = false,
      ["<C-v>"] = false,
      ["<C-u>"] = false,
      ["<C-d>"] = false,

      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
      ["<C-l>"] = actions.select_default,

      ["<C-,>"] = actions.preview_scrolling_up,
      ["<C-.>"] = actions.preview_scrolling_down,

      ["<C-b>"] = actions.results_scrolling_up,
      ["<C-f>"] = actions.results_scrolling_down,
    },
    n = {
      ["<LeftMouse>"] = { actions.mouse_click, type = "action", opts = { expr = true }, },
      ["<2-LeftMouse>"] = { actions.double_mouse_click, type = "action", opts = { expr = true }, },

      ["<esc>"] = actions.close,
      ["<C-l>"] = actions.select_default,
      ["<C-x>"] = actions.select_horizontal,
      ["<C-v>"] = actions.select_vertical,
      ["<C-t>"] = actions.select_tab,

      ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
      ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
      ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
      ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

      -- TODO: This would be weird if we switch the ordering.
      -- ["j"] = actions.move_selection_next,
      -- ["k"] = actions.move_selection_previous,
      -- ["H"] = actions.move_to_top,
      -- ["M"] = actions.move_to_middle,
      -- ["L"] = actions.move_to_bottom,

      ["<Down>"] = actions.move_selection_next,
      ["<Up>"] = actions.move_selection_previous,
      ["gg"] = actions.move_to_top,
      ["G"] = actions.move_to_bottom,

      -- ["<C-b>"] = actions.preview_scrolling_up,
      -- ["<C-f>"] = actions.preview_scrolling_down,
      -- ["<C-f>"] = actions.preview_scrolling_left,
      -- ["<C-k>"] = actions.preview_scrolling_right,

      ["?"] = actions.which_key,
      -- NOTE: custom keymappings
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,

      ["<C-b>"] = actions.results_scrolling_up,
      ["<C-f>"] = actions.results_scrolling_down,

      ["<C-,>"] = actions.preview_scrolling_up,
      ["<C-.>"] = actions.preview_scrolling_down,
    },
  }
end
M.sessionlens = { wrap_lazy("n", "<leader>sf", ":SearchSession<CR>", "Find Session"), }
M.todo_comments = { wrap_lazy("n", "<leader>ft", ":TodoTelescope<CR>", "Find todo comments"), }

-------------- Tools --------------
M.autosession = {
  wrap_lazy("n", "<leader>ss", ":SessionSave<CR>", "save session"),
  wrap_lazy("n", "<leader>sl", ":SessionRestore<CR>", "load session"), }
M.diffview = {
  wrap_lazy("n", "<leader>gd", ":DiffviewOpen<CR>", "Git diff"),
  wrap_lazy("n", "<leader>gh", ":DiffviewFileHistory %<CR>", "Show file history"), }
M.flash = {
  wrap_lazy({ "n", "x", "o" }, "s", function() require("flash").jump() end, "Flash"),
  wrap_lazy({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, "Flash Treesitter"),
  wrap_lazy("o", "r", function() require("flash").remote() end, "Remote Flash"),
  wrap_lazy({ "o", "x" }, "R", function() require("flash").treesitter_search() end, "Treesitter Search"),
  wrap_lazy({ "c" }, "<c-s>", function() require("flash").toggle() end, "Toggle Flash Search"), }
M.floaterm = {
  wrap_lazy("n", "<leader>ef", ":FloatermNew ranger<CR>", "Open ranger"),
  wrap_lazy("n", "<leader>ee", ":FloatermNew ranger $pwd<CR>", "Open ranger"),
  wrap_lazy("n", "<leader>gl", ":FloatermNew lazygit<CR>", "Open Lazygit"),
  wrap_lazy("n", "<leader>`", ":FloatermNew<CR>", "Open Terminal"),
  wrap_lazy("n", "<C-\\>", ":FloatermToggle<CR>"),
  wrap_lazy("t", "<C-,>", [[<C-\><C-n>:FloatermPrev<CR>]]),
  wrap_lazy("t", "<C-.>", [[<C-\><C-n>:FloatermNext<CR>]]),
  wrap_lazy("t", "<C-\\>", [[<C-\><C-n>]]), }
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

M.which_key = {
  { "<leader>b",  group = "Buffer" },
  { "<leader>c",  group = "Clipboard" },
  { "<leader>D",  group = "Debug Tool" },
  { "<leader>e",  group = "File Explorer" },
  { "<leader>f",  group = "Find" },
  { "<leader>g",  group = "Git" },
  { "<leader>h",  group = "Http Tool" },
  { "<leader>l",  group = "Code LSP" },
  { "<leader>t", group = "Code Test" },
  { "<leader>lw", group = "Workspace" },
  { "<leader>t",  group = "Unit Tests" },
  { "<leader>p",  group = "Plugin(Lazy)" },
  { "<leader>r",  group = "Search/Replace" },
  { "<leader>s",  group = "Session" },
  { "<leader>x",  group = "Database Tool" },
  { "<leader>g",  group = "Git",           mode = "v" },
}

return M
