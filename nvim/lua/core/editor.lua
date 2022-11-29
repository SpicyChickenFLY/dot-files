local cmd = vim.cmd
local opt = vim.opt
local g = vim.g

cmd([[ filetype plugin indent on ]])

local augroup_name = 'CosmicNvimEditor'
local group = vim.api.nvim_create_augroup(augroup_name, { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  command = [[%s/\s\+$//e]],
  group = group,
})

g.mapleader = ' '

-- misc
opt.background = 'light'
opt.backspace = { 'eol', 'start', 'indent' }
opt.clipboard = 'unnamedplus'
opt.encoding = 'utf-8'
opt.matchpairs = { '(:)', '{:}', '[:]', '<:>' }
opt.syntax = 'enable'

-- indention
opt.autoindent = true
opt.smartindent = true
-- tabstop 选项只修改 tab 字符的显示宽度，不修改按 Tab 键的行为
-- softtabstop 选项修改按 Tab 键的行为，不修改 tab 字符的显示宽度。具体行为跟 tabstop 选项值有关
-- expandtab 选项把插入的 tab 字符替换成特定数目的空格。具体空格数目跟 tabstop 选项值有关
local indent = 2
opt.expandtab = true
opt.tabstop = indent
opt.softtabstop = indent
opt.shiftwidth = indent
cmd([[ autocmd FileType go setlocal ts=4 sts=2 sw=2 noexpandtab ]])

-- search
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.wildignore = opt.wildignore + { '*/node_modules/*', '*/.git/*', '*/vendor/*' }
opt.wildmenu = true

-- ui
opt.cursorline = true
opt.laststatus = 2
opt.lazyredraw = true
opt.list = true
opt.listchars = {
  tab = '> ',
  trail = '·',
  space = ' ',
  lead = ' ',
  extends = '»',
  precedes = '«',
  nbsp = '×',
}
opt.mouse = 'a'
opt.number = true
opt.rnu = false
opt.scrolloff = 18
opt.showmode = false
opt.sidescrolloff = 3 -- Lines to scroll horizontally
opt.signcolumn = 'yes'
opt.splitbelow = true -- Open new split below
opt.splitright = true -- Open new split to the right
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

-- fold
--[[ opt.fillchars = { eob= '', fold= '', foldopen='', foldsep= '', foldclose= '' } ]] -- syntax err
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
opt.foldcolumn = '0' -- '0' is not bad
opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99
opt.foldenable = true
