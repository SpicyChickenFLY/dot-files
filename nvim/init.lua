if vim.fn.has('nvim-0.8') == 0 then
  error('Need Neovim v0.8+')
end

-- 加载编辑器核心配置
local ok , err = pcall(require, 'core')
local core_err = 'Loading core failed:'
assert(ok, core_err .. "\n" .. err)

-- 加载基本键位配置
require("core.mappings").load "general"

-- 安装lazy.nvim 插件包管理器
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.cmd "redraw"
  vim.api.nvim_echo({ { "  Installing lazy.nvim & plugins ...", "Bold" } }, true, {})
  local repo = "https://github.com/folke/lazy.nvim.git"
  local args = { "git", "clone", "--filter=blob:none", "--branch=stable", repo, lazypath }
  local output = vim.fn.system(args)
  local err_txt = "External call failed(" .. vim.v.shell_error .. "):"
  assert(vim.v.shell_error == 0, err_txt .. "\n" .. output)
end
-- 下载 或 加载组件
vim.opt.rtp:prepend(lazypath)
require "plugins"

require("core.mappings").load "lazy"
