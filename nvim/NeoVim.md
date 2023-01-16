# NeoVim
 init.lua 其实就是lua版本的init.vim
init.lua中实际上是通过调用neovim中的API来实现vimscript中的内容

尚未实现的功能:
* [ ] 代码折叠左侧符号（尚未修复）
* [ ] Trouble/Telescope/Reference 从列表选择完毕后自动关闭窗口
* [x] 统一各个组件的颜色配置
* [?] 每个窗口一个的buffer line (暂时看来是不可能了)
* [ ] scrollbar wrap时不能显示最后字符，确认bug，暂且停用

侧边栏符号显示优先级
> LSP diagnostic > git更改 > TODO符号

