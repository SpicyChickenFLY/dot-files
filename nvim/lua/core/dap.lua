local dap = require("dap")

dap.adapters.delve = {
  type = "server",
  port = "${port}",
  executable = {
    command = "dlv",
    args = { "dap", "-l", "127.0.0.1:${port}" },
  },
}

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}",
  },
  {
    type = "delve",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}",
  },
  -- works with go.mod packages and sub packages
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}",
  },
}

-- `DapBreakpoint` for breakpoints (default: `B`)
-- `DapBreakpointCondition` for conditional breakpoints (default: `C`)
-- `DapLogPoint` for log points (default: `L`)
-- `DapStopped` to indicate where the debugee is stopped (default: `→`)
-- `DapBreakpointRejected` to indicate breakpoints rejected by the debug adapter (default: `R`)

-- You can customize the signs by setting them with the |sign_define()| function.
-- For example:

vim.fn.sign_define('DapBreakpoint', {text='', texthl='red'})
vim.fn.sign_define('DapBreakpointCondition', {text='', texthl='red'})
vim.fn.sign_define('DapLogPoint', {text='', texthl='red'})
vim.fn.sign_define('DapStopped', {text='', texthl='red'})
vim.fn.sign_define('DapBreakpointRejected', {text='', texthl='red'})

local dapui = require("dapui")
dapui.setup({
  icons = { expanded = "", collapsed = "", current_frame = "" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Use this to override mappings for specific elements
  element_mappings = {
    -- Example:
    -- stacks = {
    --   open = "<CR>",
    --   expand = "o",
    -- }
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7") == 1,
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
        -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  controls = {
    -- Requires Neovim nightly (or 0.8 when released)
    enabled = true,
    -- Display controls in this element
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "",
      terminate = "",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close({})
end

vim.cmd([[
  hi  link DapUIVariable Normal
  hi  link DapUIValue Normal
  hi  link DapUIFrameName Normal
  hi  link DapUIFloatNormal NormalFloat
  hi  link DapUIBreakpointsLine DapUILineNumber
  hi  link DapUICurrentFrameName DapUIBreakpointsCurrentLine

  hi  DapUIThread guifg=#91b859
  hi  DapUIWatchesValue guifg=#91b859
  hi  DapUIBreakpointsInfo guifg=#91b859
  hi  DapUIBreakpointsCurrentLine guifg=#91b859 gui=bold
  hi  DapUIPlayPause guifg=#91b859
  hi  DapUIRestart guifg=#91b859
  hi  DapUIType guifg=#D484FF
  hi  DapUISource guifg=#D484FF
  hi  DapUIScope guifg=#6182b8
  hi  DapUIModifiedValue guifg=#6182b8 gui=bold
  hi  DapUIDecoration guifg=#6182b8
  hi  DapUIStoppedThread guifg=#6182b8
  hi  DapUILineNumber guifg=#6182b8
  hi  DapUIFloatBorder guifg=#6182b8
  hi  DapUIBreakpointsPath guifg=#6182b8
  hi  DapUIStepOver guifg=#6182b8
  hi  DapUIStepInto guifg=#6182b8
  hi  DapUIStepBack guifg=#6182b8
  hi  DapUIStepOut guifg=#6182b8
  hi  DapUIWatchesEmpty guifg=#e53935
  hi  DapUIWatchesError guifg=#e53935
  hi  DapUIStop guifg=#e53935
  hi  DapUIBreakpointsDisabledLine guifg=#424242
  hi  DapUIUnavailable guifg=#424242
  ]])
