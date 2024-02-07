if vim.fn.has('nvim-0.8') == 0 then
  error('Need Neovim v0.8+')
end

local function echo(str)
  vim.cmd "redraw"
  vim.api.nvim_echo({ { str, "Bold" } }, true, {})
end

local function shell_call(args)
  local output = vim.fn.system(args)
  local err_txt = "External call failed(" .. vim.v.shell_error .. "):"
  assert(vim.v.shell_error == 0, err_txt .. "\n" .. output)
end

-- 加载编辑器核心配置
local ok , err = pcall(require, 'core')
if not ok then
  error(('loading core failed:\n%s'):format(err))
end

-- 加载基本键位配置
require("core.mappings").load "general"

-- 安装lazy.nvim 插件包管理器
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  echo "  Installing lazy.nvim & plugins ..."
  local repo = "https://github.com/folke/lazy.nvim.git"
  shell_call { "git", "clone", "--filter=blob:none", "--branch=stable", repo, lazypath }
end
-- 下载 或 加载组件
vim.opt.rtp:prepend(lazypath)
require "plugins"

require("core.mappings").load "lazy"
