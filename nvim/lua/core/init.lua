-- [[ 禁用vim的一些内置插件 ]]
local disabled_built_ins = {
  'netrw', 'netrwPlugin', 'netrwSettings', 'netrwFileHandlers', -- builtin file explorer
  'gzip', 'zip', 'zipPlugin', 'tar', 'tarPlugin', -- edit compressed files
  'getscript', 'getscriptPlugin',
  'vimball', 'vimballPlugin', -- create and unpack .vba files
  '2html_plugin', 'tohtml', -- convert a file with highlight to html
  'logipat', -- operators on pattern
  'rrhelper', -- remote wait editing
  'spellfile_plugin', -- downlload spell file
  'matchit', -- highlight
  'tutor', 'rplugin', 'syntax', 'synmenu', 'optwin', 'compiler', 'bugreport',
}
for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

-- [[ 加载编辑器基本参数配置 ]]
local ok, err = pcall(require, 'core.editor')
if not ok then
  error(('Error loading core...\n%s'):format(err))
end
