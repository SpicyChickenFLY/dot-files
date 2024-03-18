return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    {
      'mfussenegger/nvim-dap',
      config = function()
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

        -- You do not have to define dap.adapters.java yourself if you use nvim-jdtls
        -- dap.adapters.java = {}
        -- dap.adapters.java = function(callback) end
        dap.configurations.java = {
          -- {
          --   type = "java",
          --   name = "Debug(Attach) - Host",
          --   request = "attach",
          --   hostName = "127.0.0.1",
          --   port = 5005,
          -- },
          -- {
          --   type = "java",
          --   name = "Debug(Attach) - Process",
          --   request = "attach",
          --   processId = "${command:PickJavaProcess}",
          -- },
        }

        dap.adapters.bashdb = {
          type = 'executable';
          command = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/bash-debug-adapter';
          name = 'bashdb';
        }
        dap.configurations.sh = {
          {
            type = 'bashdb';
            request = 'launch';
            name = "Launch file";
            showDebugOutput = true;
            pathBashdb = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb';
            pathBashdbLib = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir';
            trace = true;
            file = "${file}";
            program = "${file}";
            cwd = '${workspaceFolder}';
            pathCat = "cat";
            pathBash = "/bin/bash";
            pathMkfifo = "mkfifo";
            pathPkill = "pkill";
            args = {};
            env = {};
            terminalKind = "integrated";
          }
        }

        -- `DapBreakpoint` for breakpoints (default: `B`)
        -- `DapBreakpointCondition` for conditional breakpoints (default: `C`)
        -- `DapLogPoint` for log points (default: `L`)
        -- `DapStopped` to indicate where the debugee is stopped (default: `→`)
        -- `DapBreakpointRejected` to indicate breakpoints rejected by the debug adapter (default: `R`)

        -- You can customize the signs by setting them with the |sign_define()| function.
        -- For example:

        vim.fn.sign_define('DapBreakpoint', {text='', texthl='DapUIStop'})
        vim.fn.sign_define('DapBreakpointCondition', {text='', texthl='DapUIStop'})
        vim.fn.sign_define('DapLogPoint', {text='', texthl='DapUIStop'})
        vim.fn.sign_define('DapStopped', {text='', texthl='DapUIStop'})
        vim.fn.sign_define('DapBreakpointRejected', {text='', texthl='DapUIStop'})

        local dapui = require("dapui")
        dapui.setup({
          icons = { expanded = "", collapsed = "", current_frame = "" },
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
          force_buffers = true,
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
            indent = 2,
            max_type_length = nil, -- Can be integer or nil.
            max_value_lines = 100, -- Can be integer or nil.
          },
        })

        dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open({}) end
        dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close({}) end
        dap.listeners.before.event_exited["dapui_config"] = function() dapui.close({}) end

        require("nvim-dap-virtual-text").setup({})
      end,
    }, -- DAP client
    {
      "theHamsta/nvim-dap-virtual-text",
      config = function() require("nvim-dap-virtual-text").setup({}) end,
    }, -- DAP virtual text
  },
  keys = require("core.keymaps")["dap"],
} -- DAP UI
