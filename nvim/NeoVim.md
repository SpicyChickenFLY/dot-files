# NeoVim
 init.lua 其实就是lua版本的init.vim
init.lua中实际上是通过调用neovim中的API来实现vimscript中的内容

### Color
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
* [ ] 代码折叠
* [ ] Trouble/Telescope/Reference 从列表选择完毕后自动关闭窗口
* [ ] 统一各个组件的颜色配置
* [ ] 统一各个组件的图标配置
* [?] 每个窗口一个的buffer line (暂时看来是不可能了)

侧边栏符号显示优先级
> LSP diagnostic > git更改 > TODO符号
