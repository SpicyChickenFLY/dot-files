local icons = require("core.icons")

local function searchCount()
  local search = vim.fn.searchcount({ maxcount = 0 }) -- maxcount = 0 makes the number not be capped at 99
  local searchCurrent = search.current
  local searchTotal = search.total
  if searchCurrent > 0 and vim.v.hlsearch ~= 0 then
    return vim.fn.getreg("/") .. " [" .. searchCurrent .. "/" .. searchTotal .. "]"
  else
    return ""
  end
end

local todoCommentMap = {
  FIX = { icon = icons.debug, color = "error" },
  TODO = { icon = icons.check, color = "info" },
  WARN = { icon = icons.warn, color = "warning" },
  PERF = { icon = icons.perf, color = "environment"},
  HACK = { icon = icons.flame, color = "warning" },
  -- NOTE = { icon = icons.note, color = "hint" },
}
local todoCommentStat = {}
local function todoCount()
  if not require('todo-comments.config').loaded then return '' end
  local filepath = vim.fn.expand('%')
  -- only search current file(else do nothing for performance)
  if filepath == '' or vim.fn.isdirectory(filepath) ~= 0 or vim.fn.filereadable(filepath) == 0 then return '' end

  require("todo-comments.search").search(
    function(entries)
      todoCommentStat = {}
      for _, entry in ipairs(entries) do
        if todoCommentMap[entry.tag] ~= nil then
          todoCommentStat[entry.tag] = (todoCommentStat[entry.tag] or 0) + 1
        end
      end
    end, { cwd = filepath,  disable_not_found_warnings = true }
  )

  local out = {}
  for keyword, count in vim.spairs(todoCommentStat) do
    local icon = todoCommentMap[keyword].icon
    local formatStr = '%%#TODOFg%s#%s %d '
    table.insert(out, (formatStr):format(keyword, icon, count))
  end
  return table.concat(out)
end

local modeMap = {}
modeMap["NORMAL"] = " N "
modeMap["INSERT"] = " I "
modeMap["COMMAND"] = " C "
modeMap["REPLACE"] = " R "
modeMap["TERMINAL"] = " T "
modeMap["VISUAL"] = " V "
modeMap["V-LINE"] = "V-L"
modeMap["V-BLOCK"] = "V-B"
modeMap["SELECT"] = " S "
modeMap["S-LINE"] = "S-L"

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "catppuccin",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "packer", "mason", "NvimTree", "trouble", "Outline" },
    ignore_focus = {},
    always_divide_middle = false,
    globalstatus = true,
    refresh = { statusline = 1000, tabline = 1000, winbar = 1000, },
  },
  sections = {
    lualine_a = {
      {
        "mode",
        fmt = function(mode_str) return modeMap[mode_str] end,
      },
    },
    lualine_b = { "branch" },
    lualine_c = { "diagnostics", { searchCount }, { todoCount } },
    lualine_x = { },
    -- lualine_x = {'b:gitsigns_blame_line'},
    lualine_y = { "filetype", "encoding", "fileformat" },
    lualine_z = { "%l:%c", "progress" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  globalstatus = true,
  extensions = {},
})
