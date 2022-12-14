local function searchCount()
    local search = vim.fn.searchcount({maxcount = 0}) -- maxcount = 0 makes the number not be capped at 99
    local searchCurrent = search.current
    local searchTotal = search.total
    if searchCurrent > 0 and vim.v.hlsearch ~= 0 then
        return vim.fn.getreg("/").." ["..searchCurrent.."/"..searchTotal.."]"
    else
        return ""
    end
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    --[[ component_separators = { left = '', right = ''}, ]]
    --[[ section_separators = { left = '', right = ''}, ]]
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = { 'packer', 'mason', 'NvimTree', 'trouble', 'Outline'
    },
    ignore_focus = {},
    always_divide_middle = false,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {
      {
        'mode',
        fmt = function(mode_str)
          local modeMap = {}
            modeMap["NORMAL"] = " N "
            modeMap["INSERT"] = " I "
            modeMap["COMMAND"] = " C "
            modeMap["REPLACE"] = " R "
            modeMap["TERMINAL"] = " T "
            modeMap["SELECT"] = " S "
            modeMap["VISUAL"] = " V "
            modeMap["V-LINE"] = "V-L"
            modeMap["V-BLOCK"] = "V-B"
            modeMap["SELECT"] = " S "
            modeMap["S-LINE"] = "S-L"
          return modeMap[mode_str]
        end
      }
    },
    lualine_b = {
      'branch',
      {
        'diff',
        -- symbols = { added = ' ', modified = ' ', removed = ' ', },
        -- symbols = { added = '+', modified = '~', removed = '-', },
        symbols = { added = '', modified = '', removed = '', },
      },
    },
    lualine_c = {
      'filename',
      'diagnostics',
      { searchCount },
    },
    lualine_x = {'b:gitsigns_blame_line'},
    lualine_y = {'filetype', 'encoding', 'fileformat'},
    lualine_z = {'%l:%c', 'progress'},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  globalstatus = true,
  extensions = {}
}

