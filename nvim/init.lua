if vim.fn.has('nvim-0.8') == 0 then
  error('Need Neovim v0.8+')
end

-- 加载编辑器核心配置
local ok , err = pcall(require, 'core')
if not ok then
  error(('Error loading core module...\n\n%s'):format(err))
end

-- 加载基本键位配置
require("core.mappings").load_mappings "general"

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- 安装lazy.nvim 编译组件字节流 并 下载安装插件
if not vim.loop.fs_stat(lazypath) then
  require("bootstrap").lazy(lazypath)
end

-- 加载组件
vim.opt.rtp:prepend(lazypath)
require "plugins"

require("core.mappings").load_mappings()

vim.cmd('colorscheme catppuccin-latte')
vim.cmd('colorscheme catppuccin-latte')
