require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    --[[ component_separators = { left = '', right = ''}, ]]
    --[[ section_separators = { left = '', right = ''}, ]]
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = { 'packer', 'mason', 'NvimTree', 'trouble'
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
    lualine_a = {{'mode', fmt = function(mode_str)
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
    } },
    lualine_b = {
      'branch',
      {
        'diff',
        symbols = { added = ' ', modified = ' ', removed = ' ', },
      }
    },
    lualine_c = {
      'filename',
      {
        'diagnostics',
        --[[ symbols = {error = '', warn = '', info = '', hint = ''} ]]
      }
    },
    lualine_x = {'filetype'},
    lualine_y = {'encoding', 'fileformat'},
    lualine_z = {'%l:%c', 'progress'}
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
