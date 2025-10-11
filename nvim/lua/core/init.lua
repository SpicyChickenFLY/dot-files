-- [[ 加载编辑器基本参数配置 ]]

-- 加载基本键位配置
vim.schedule(require("core.keymaps").general)

local icons = require("core.icons")
---------------------------- Path ------------------------------
-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

---------------------------- Global ------------------------------
local g = vim.g
g.skip_ts_context_commentstring_module = true
g.mapleader = " "

require("core.options")

---------------------------- Commands ------------------------------
local cmd = vim.cmd
cmd([[filetype plugin indent on]])

---------------------------- AutoCommands ------------------------------
local autocmd = vim.api.nvim_create_autocmd
-- 打开新Buffer时把i3.config结尾的文件看作i3config文件类型
autocmd({ "BufRead", "BufEnter", "BufNewFile" }, {
    pattern = "*.i3.config",
    callback = function() cmd([[set filetype=i3config]]) end,
})
-- 打开新Buffer时把http结尾的文件看作rest测试文件类型
autocmd({ "BufRead", "BufEnter", "BufNewFile" }, {
    pattern = "*.http",
    callback = function() cmd([[set filetype=http]]) end,
})
-- close some filetypes with <q>
autocmd("FileType", {
    pattern = {
        "PlenaryTestPopup",
        "help",
        "lspinfo",
        "man",
        "notify",
        "qf",
        "query", -- :InspectTree
        "spectre_panel",
        "neo-tree-preview",
        "neotest-output",
        "sqls_output",
        "rest_nvim_result",
    },
    callback = function(event)
        -- :help api-autocmd
        -- nvim_create_autocmd's callback receives a table argument with fields
        -- event = {id,event,group?,match,buf,file,data(arbituary data)}
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})
autocmd("FileType", {
    pattern = { "Avante*", },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>AvanteToggle<cr>", { buffer = event.buf, silent = true })
    end,
})

