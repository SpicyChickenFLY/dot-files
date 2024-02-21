-- [[ 加载编辑器基本参数配置 ]]
--
local icons = require("core.icons")

---------------------------- Path ------------------------------
-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

---------------------------- Global ------------------------------
local g = vim.g
g.skip_ts_context_commentstring_module = true
g.mapleader = " "

---------------------------- Options ------------------------------
local opt = vim.opt
-- Misc
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.encoding = "utf-8"
opt.fileencodings = "utf-8,ucs-bom,gbk,cp936,gb2312,gb18030"
opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }
opt.backspace = { "eol", "start", "indent" }
opt.shortmess:append("sI") -- 禁用开头介绍

-- UI
opt.background = "light"
opt.termguicolors = true
opt.syntax = "disable"
-- opt.showmode = false
opt.laststatus = 3 -- global statusline
opt.cursorline = true
opt.list = true
opt.listchars = icons.listchars
opt.signcolumn = "yes"
opt.scrolloff = 5 -- 当游标离上下N行时滚动
opt.sidescrolloff = 5 -- 当游标离左右N列时滚动
opt.wrap = true -- 开启折行显示
opt.whichwrap:append("<>[]hl") -- 允许hl移动换行

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.relativenumber = false
opt.ruler = false

-- Spliting
opt.splitkeep = "screen"
opt.splitbelow = false -- Open new split below
opt.splitright = false -- Open new split to the right

-- Indenting
local indent = 4
opt.autoindent = true -- 开启自动缩进
opt.smartindent = true -- 开启智能缩进,首先需要开启自动缩进
opt.shiftwidth = indent -- 自动缩进长度
opt.tabstop = indent -- 只修改制表符的显示宽度
opt.softtabstop = indent -- 按Tab键的行为, 行为跟tabstop有关
opt.expandtab = true -- 按Tab键替换成空格。数目跟tabstop有关

-- Searching
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.wildignore = opt.wildignore + { "*/node_modules/*", "*/.git/*", "*/vendor/*" }
opt.wildmenu = true

-- Folding
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:,diff: ]]
opt.foldcolumn = "1" -- '0' is not bad
opt.foldlevel = 99 -- Using ufo provider need a large value
opt.foldlevelstart = 99
opt.foldenable = true

-- Backups
opt.backup = false
opt.swapfile = false
opt.writebackup = false

-- Perfomance
opt.redrawtime = 1500
opt.timeout = true
opt.timeoutlen = 400
opt.ttimeoutlen = 10
opt.updatetime = 250
opt.undofile = true

-- theme
opt.termguicolors = true
opt.background = "light"

---------------------------- Commands ------------------------------
local cmd = vim.cmd
cmd([[filetype plugin indent on]])

---------------------------- AutoCommands ------------------------------
local autocmd = vim.api.nvim_create_autocmd
-- 打开新Buffer时把i3.config结尾的文件看作i3config文件类型
autocmd({ "BufRead", "BufEnter", "BufNewFile" }, {
	pattern = "*.i3.config",
	callback = function()
		cmd([[set filetype=i3config]])
	end,
})
autocmd({ "BufRead", "BufEnter", "BufNewFile" }, {
	pattern = "*.http",
	callback = function()
		cmd([[set filetype=http]])
	end,
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
    },
    callback = function(event)
        -- :help api-autocmd
        -- nvim_create_autocmd's callback receives a table argument with fields
        -- event = {id,event,group?,match,buf,file,data(arbituary data)}
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true }, "close some filetype windows with <q>")
    end,
})
