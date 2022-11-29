# NeoVim
 init.lua 其实就是lua版本的init.vim
init.lua中实际上是通过调用neovim中的API来实现vimscript中的内容


## Plugins
neovim中的插件默认是lazyload
### UI
    'kyazdani42/nvim-web-devicons' -- 图标
    'yamatsum/nvim-nonicons' -- devicons的升级版?
    gitsigns.nvim
    filipdutescu/renamer.nvim
### Package Manager
'bthomason/packer.nvim'
### Framework
    'romgrk/barbar.nvim' -- Tabline - 上方Buffer状态栏
    'NTBBloodbath/galaxyline.nvim' -- Status Line - 下方状态栏

### Fuzzy Finder - 文件模糊搜索器
'nvim-telescope/telescope.nvim'
### File Explorer - 文件浏览器
'kyazdani42/nvim-tree.lua'
### LSP
'neovim/nvim-lspconfig'
'williamboman/mason.nvim'
### Completion
nvim-cmp
### Indent
'lukas-reineke/indent-blankline.nvim'
### Startup
'goolord/alpha-nvim'
### Color
'NvChad/nvim-colorizer.lua'
'sunjon/Shade.nvim'
'winston0410/range-highlight.nvim'
### Syntax
'nvim-treesitter/nvim-treesitter'
### Comment
'numToStr/Comment.nvim'
### Session
'rmagatti/auto-session'
### Editing support
'windwp/nvim-autopairs'
'p00f/nvim-ts-rainbow'
'windwp/nvim-ts-autotag'
'folke/which-key.nvim'

尚未实现的功能:
* [] ctrl-v 黏贴
* [x] 复制内容至剪贴板,黏贴剪贴板内容
* [ ] 代码折叠

侧边栏符号显示优先级
> LSP diagnostic > git更改 > TODO符号
