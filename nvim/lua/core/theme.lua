local M = {}

M.get_highlight = function(hi)
  local hi_str = vim.api.nvim_command_output(('hi %s'):format(hi))

  local colors = {}
  for key, val in string.gmatch(hi_str, '(%w+)=(%S+)') do
    colors[key] = val
  end

  return colors
end

M.set_highlight = function(hi, colors)
  local hi_str = ''

  for k, v in pairs(colors) do
    hi_str = hi_str .. k .. '=' .. v .. ' '
  end

  vim.cmd(('hi %s %s'):format(hi, hi_str))
end

vim.o.background = 'light'
vim.cmd('colorscheme catppuccin-latte')
-- TODO: add named color highlight
--
vim.cmd('hi Folded guibg=#d8ded9')
vim.cmd('hi link UfoFoldedEllipsis ModeMsg')

-- vim.cmd('hi link BufferInactive ')

-- set highlight for diagnostic
local statusline_colors = M.get_highlight('StatusLine')
local error_colors = M.get_highlight('DiagnosticError')
local warning_colors = M.get_highlight('DiagnosticWarn')
local hint_colors = M.get_highlight('DiagnosticHint')
local info_colors = M.get_highlight('DiagnosticInfo')
M.set_highlight('DiagnosticErrorInv',
  { guibg = error_colors.guifg, guifg = statusline_colors.guibg, })
M.set_highlight('DiagnosticWarnInv',
  { guibg = warning_colors.guifg, guifg = statusline_colors.guibg, })
M.set_highlight('DiagnosticHintInv',
  { guibg = hint_colors.guifg, guifg = statusline_colors.guibg, })
M.set_highlight('DiagnosticInfoInv',
  { guibg = info_colors.guifg, guifg = statusline_colors.guibg, })

vim.fn.sign_define("DiagnosticSignHint", {text = '', texthl ="DiagnosticSignHint", numhl ="DiagnosticSignHint"})
vim.fn.sign_define("DiagnosticSignInfo", {text = '', texthl ="DiagnosticSignInfo", numhl ="DiagnosticSignInfo"})
vim.fn.sign_define("DiagnosticSignWarn", {text = '',  texthl ="DiagnosticSignWarn", numhl ="DiagnosticSignWarn"})
vim.fn.sign_define("DiagnosticSignError", {text = '', texthl ="DiagnosticSignError", numhl ="DiagnosticSignError"})

