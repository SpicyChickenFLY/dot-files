-- [[ disable some vim builtins ]]
local disabled_built_ins = {
  'netrw', 'netrwPlugin', 'netrwSettings', 'netrwFileHandlers', -- builtin file explorer
  'gzip', 'zip', 'zipPlugin', 'tar', 'tarPlugin', -- edit compressed files
  'getscript', 'getscriptPlugin',
  'vimball', 'vimballPlugin', -- create and unpack .vba files
  '2html_plugin', -- convert a file with highlight to html
  'logipat', -- operators on pattern
  'rrhelper', -- remote wait editing
  'spellfile_plugin', -- downlload spell file
  'matchit', -- hilight
}
for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

-- [[ Custom Named Commands ]]
local augroup_name = 'MyNvim'
local group = vim.api.nvim_create_augroup(augroup_name, { clear = true })
vim.api.nvim_create_autocmd('VimResized', {
  command = 'tabdo wincmd =',
  group = group,
})
vim.cmd([[ command! LspFormat lua vim.lsp.buf.format() ]])

local ok, err = pcall(require, 'compiled')
if not ok then
  vim.notify('Run :PackerCompile!', vim.log.levels.WARN, { title = 'ChowNvim', })
end


-- [[ load other core modules ]]
local modules = {
  'core.editor',
  'core.plugins',
  'core.lsp',
  'core.dap',
  'core.mappings',
}
for _, mod in ipairs(modules) do
  ok, err = pcall(require, mod)
  if not ok then
    error(('Error loading %s...\n%s'):format(mod, err))
  end
end
