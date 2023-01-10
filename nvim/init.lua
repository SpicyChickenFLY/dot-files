if vim.fn.has('nvim-0.8') == 0 then
  error('Need Neovim v0.8+')
end

do
  local ok, _ = pcall(require, 'impatient')
  if not ok then
    vim.notify('impatient.nvim not installed', vim.log.levels.WARN)
  end
end


local ok , err = pcall(require, 'core')
if not ok then
  error(('Error loading core module...\n\n%s'):format(err))
end

vim.cmd('colorscheme catppuccin-latte')
