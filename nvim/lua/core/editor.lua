local cmd = vim.cmd
local opt = vim.opt
local g = vim.g

cmd([[ filetype plugin indent on ]])
cmd([[ au BufRead,BufNewFile *.i3.config set filetype=i3config ]])

g.skip_ts_context_commentstring_module = true
g.mapleader = ' '

-- misc
opt.background = 'light'
opt.backspace = { 'eol', 'start', 'indent' }
opt.clipboard = 'unnamedplus'
opt.encoding = 'utf-8'
opt.matchpairs = { '(:)', '{:}', '[:]', '<:>' }
opt.syntax = 'disable'

-- Indent ans Tab
local indent = 4
opt.autoindent = true -- 开启自动缩进
opt.smartindent = true -- 开启智能缩进,首先需要开启自动缩进
opt.shiftwidth = indent -- 自动缩进长度

opt.tabstop = indent -- 只修改Tab字符的显示宽度
opt.softtabstop = indent -- 修改按 Tab 键的行为, 具体行为跟 tabstop 有关
opt.expandtab = true -- 按 tab 键替换成特定数目的空格。数目跟 tabstop 有关

-- 如果不希望通过guess-indent算法自动检测缩进的话可以通过下述内容进行文件类型的固定
-- cmd([[ autocmd FileType go setlocal ts=4 sts=2 sw=2 noexpandtab ]])

-- search
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.wildignore = opt.wildignore + { '*/node_modules/*', '*/.git/*', '*/vendor/*' }
opt.wildmenu = true

-- ui
opt.cursorline = true
opt.laststatus = 3
opt.splitkeep = "screen"
opt.lazyredraw = true
opt.list = true
opt.listchars = {
  tab = '  →',
  trail = '·',
  space = ' ',
  lead = '·',
  extends = '»',
  precedes = '«',
  nbsp = '×',
}
opt.mouse = 'a'
opt.number = true
opt.rnu = false
opt.scrolloff = 5 -- 当游标达到离顶部与底部还有N行时,继续移动会导致页面滚动
opt.showmode = false
opt.sidescrolloff = 3 -- Lines to scroll horizontally
opt.signcolumn = 'yes'
opt.splitbelow = false -- Open new split below
opt.splitright = false -- Open new split to the right
opt.wrap = true

-- backups
opt.backup = false
opt.swapfile = false
opt.writebackup = false

-- autocomplete
opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.shortmess = opt.shortmess + { c = true }

-- perfomance
opt.redrawtime = 1500
opt.timeoutlen = 250
opt.ttimeoutlen = 10
opt.updatetime = 100

-- theme
opt.termguicolors = true
opt.background = 'light'

-- fold
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:,diff: ]]
opt.foldcolumn = '1' -- '0' is not bad
opt.foldlevel = 99 -- Using ufo provider need a large value
opt.foldlevelstart = 99
opt.foldenable = true

