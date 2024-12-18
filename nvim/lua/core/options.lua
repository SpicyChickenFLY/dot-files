local icons = require("core.icons")

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
opt.scrolloff = 5              -- 当游标离上下N行时滚动
opt.sidescrolloff = 5          -- 当游标离左右N列时滚动
opt.wrap = true                -- 开启折行显示
opt.whichwrap:append("<>[]hl") -- 允许hl移动换行

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true
opt.ruler = false

-- Spliting
opt.splitkeep = "screen"
opt.splitbelow = false -- Open new split below
opt.splitright = false -- Open new split to the right

-- Indenting
local indent = 4
opt.autoindent = true    -- 开启自动缩进
opt.smartindent = true   -- 开启智能缩进,首先需要开启自动缩进
opt.shiftwidth = indent  -- 自动缩进长度
opt.tabstop = indent     -- 只修改制表符的显示宽度
opt.softtabstop = indent -- 按Tab键的行为, 行为跟tabstop有关
opt.expandtab = true     -- 按Tab键替换成空格。数目跟tabstop有关

-- Searching
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.wildignore = opt.wildignore + { "*/node_modules/*", "*/.git/*", "*/vendor/*" }
opt.wildmenu = true

-- Folding
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:,diff: ]]
opt.foldcolumn = "1" -- '0' is not bad
opt.foldlevel = 99   -- Using ufo provider need a large value
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
