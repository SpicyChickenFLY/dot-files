local icons = require("core.icons")

local modeMap = {
  ["NORMAL"] = " N",
  ["INSERT"] = " I",
  ["COMMAND"] = " C",
  ["REPLACE"] = " R",
  ["TERMINAL"] = " T",
  ["VISUAL"] = " V",
  ["V-LINE"] = "VL",
  ["V-BLOCK"] = "VB",
  ["SELECT"] = " S",
  ["S-LINE"] = "SL",
}

local function indentCount()
  local indicator = vim.o.expandtab and "S:" or "T:"
  return indicator .. vim.o.tabstop
end

local function searchCount()
  local search = vim.fn.searchcount({ maxcount = 0 }) -- maxcount = 0 makes the number not be capped at 99
  local searchCurrent = search.current
  local searchTotal = search.total
  if searchCurrent > 0 and vim.v.hlsearch ~= 0 then
    return " [" .. searchCurrent .. "/" .. searchTotal .. "]" -- use vim.fn.getreg("/") if need search content
  else
    return ""
  end
end

local function flutterInfo()
end

local function dbInfo()
  local info = ""
  -- 获取当前 buffer 的 LSP 客户端
  local bufnr = vim.api.nvim_get_current_buf()
  local buf_clients = vim.lsp.buf_get_clients(bufnr)
  for _, buf_client in ipairs(buf_clients) do
    if buf_client.name == "sqls" then
      info = icons.db_icons[vim.g.sqls_driver_type] or vim.g.sqls_driver_type
      info = info .. " " .. vim.g.sqls_connection_choice
      if vim.g.sqls_database_choice then
        info = info .. " 󰆼 " .. vim.g.sqls_database_choice
      end
    end
  end
  return info
end

local function visualCount()
  local isVisualMode = vim.fn.mode():find("[Vv]")
  if not isVisualMode then
    return ""
  end
  local startPos = vim.fn.line("v")
  local endPos = vim.fn.line(".")
  local lines = startPos <= endPos and endPos - startPos + 1 or startPos - endPos
  return "(" .. tostring(lines) .. ":" .. tostring(vim.fn.wordcount().visual_chars) .. ")"
end

local todoCommentMap = {
  FIX = { icon = icons.debug, color = "error" },
  TODO = { icon = icons.check, color = "info" },
  WARN = { icon = icons.warn, color = "warning" },
  PERF = { icon = icons.perf, color = "environment" },
  HACK = { icon = icons.flame, color = "warning" },
}
local todoCommentStat = {}
local function todoCount()
  if not require("todo-comments.config").loaded then
    return ""
  end
  local filepath = vim.fn.expand("%")
  -- only search current file(else do nothing for performance)
  if filepath == "" or vim.fn.isdirectory(filepath) ~= 0 or vim.fn.filereadable(filepath) == 0 then
    return ""
  end

  require("todo-comments.search").search(function(entries)
    todoCommentStat = {}
    for _, entry in ipairs(entries) do
      if todoCommentMap[entry.tag] ~= nil then
        todoCommentStat[entry.tag] = (todoCommentStat[entry.tag] or 0) + 1
      end
    end
  end, { cwd = filepath, disable_not_found_warnings = true })

  local out = {}
  for keyword, count in vim.spairs(todoCommentStat) do
    local icon = todoCommentMap[keyword].icon
    local formatStr = "%%#TODOFg%s#%s %d"
    table.insert(out, (formatStr):format(keyword, icon, count))
  end
  return table.concat(out, " ")
end

return {
  "nvim-lualine/lualine.nvim",
  config = function()
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
        refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(mode_str)
              return modeMap[mode_str]
            end,
          },
        },
        lualine_b = { { "branch", icon = "" } },
        lualine_c = {
          {
            "diagnostics",
            symbols = {
              error = icons.error .. " ",
              warn = icons.warn .. " ",
              info = icons.info .. " ",
              hint = icons.hint .. " ",
            },
          },
          { todoCount },
          { searchCount },
        },
        lualine_x = {
          { dbInfo },
        },
        lualine_y = {
          { "filetype", icon_only = true },
          "encoding",
          "fileformat",
          indentCount,
        },
        lualine_z = {
          { "%l:%c" },
          { visualCount },
        },
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
  end,
  lazy = false,
}
