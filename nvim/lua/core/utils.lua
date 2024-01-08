local M = {}
local augroup_name = 'NeverVimUtils'
local group = vim.api.nvim_create_augroup(augroup_name, { clear = true })
local merge_tb = vim.tbl_deep_extend

function M.log(type, msg, opts)
  local ok, notify = pcall(require, 'notify')
  if ok then
    opts  = merge_tb('force', { title = 'NeverVim', }, opts)
    notify( msg, type, opts)
  else
    if vim.tbl_islist(msg) then -- regular vim.notify can't take tables of strings
      local msg_str = ''
      for _, v in pairs(msg) do msg_str = msg_str .. v end
      msg = msg_str
    end
    vim.notify(msg, type)
  end
end

function M.map(mode, lhs, rhs, opts)
  local defaults = { silent = true, noremap = true }
  vim.keymap.set(mode, lhs, rhs, M.merge(defaults, opts or {}))
end

function M.merge_list(tbl1, tbl2)
  for _, v in ipairs(tbl2) do
    table.insert(tbl1, v)
  end
  return tbl1
end

function M.merge(...)
  return vim.tbl_deep_extend('force', ...)
end

function M.split(str, sep)
  local res = {}
  for w in str:gmatch('([^' .. sep .. ']*)') do
    if w ~= '' then
      table.insert(res, w)
    end
  end
  return res
end

function M.get_active_lsp_client_names()
  local active_clients = vim.lsp.get_active_clients()
  local client_names = {}
  for _, client in pairs(active_clients or {}) do
    local buf = vim.api.nvim_get_current_buf()
    -- only return attached buffers
    if vim.lsp.buf_is_attached(buf, client.id) then
      table.insert(client_names, client.name)
    end
  end

  if not vim.tbl_isempty(client_names) then
    table.sort(client_names)
  end
  return client_names
end

local function unload(module_pattern, reload)
  reload = reload or false
  for module, _ in pairs(package.loaded) do
    if module:match(module_pattern) then
      package.loaded[module] = nil
      if reload then
        require(module)
      end
    end
  end
end

local function clear_cache()
  vim.cmd(':LuaCacheClear')
end

function M.post_reload(msg)
  -- unload('utils', true)
  -- unload('theme', true)
  -- unload('plugins.statusline', true)
  msg = msg or 'User config reloaded!'
  M.log(vim.log.levels.INFO, msg)
end

function M.reload_user_config_sync()
  clear_cache()
  unload('core.plugins', true)
  vim.api.nvim_create_autocmd('User PackerComplete', {
    callback = function()
      M.post_reload()
    end,
    group = group,
    once = true,
  })
  vim.cmd(':PackerSync')
end

function M.reload_user_config(compile)
  compile = compile or false
  if compile then
    vim.api.nvim_create_autocmd('User PackerCompileDone', {
      callback = function()
        M.post_reload()
      end,
      group = group,
      once = true,
    })
    vim.cmd(':PackerCompile')
  end
end

function M.get_install_dir()
  local config_dir = os.getenv('COSMICNVIM_INSTALL_DIR')
  if not config_dir then
    return vim.fn.stdpath('config')
  end
  return config_dir
end

-- update instance of CosmicNvim
function M.update()
  local Job = require('plenary.job')
  local path = M.get_install_dir()
  local errors = {}

  Job
      :new({
        command = 'git',
        args = { 'pull', '--ff-only' },
        cwd = path or '',
        on_start = function()
          M.log(vim.log.levels.INFO, 'Updating...')
        end,
        on_exit = function()
          if vim.tbl_isempty(errors) then
            M.log(vim.log.levels.INFO, 'Updated! Running CosmicReloadSync...')
            M.reload_user_config_sync()
          else
            table.insert(errors, 1, 'Something went wrong! Please pull changes manually.')
            table.insert(errors, 2, '')
            M.log(vim.log.levels.ERROR, 'Update failed!', { timeout = 30000 })
          end
        end,
        on_stderr = function(_, err)
          table.insert(errors, err)
        end,
      })
      :sync()
end

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

M.lazy_load = function(plugin)
  vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
    callback = function()
      local file = vim.fn.expand "%"
      local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""

      if condition then
        vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

        -- dont defer for treesitter as it will show slow highlighting
        -- This deferring only happens only when we do "nvim filename"
        if plugin ~= "nvim-treesitter" then
          vim.schedule(function()
            require("lazy").load { plugins = plugin }

            if plugin == "nvim-lspconfig" then
              vim.cmd "silent! do FileType"
            end
          end, 0)
        else
          require("lazy").load { plugins = plugin }
        end
      end
    end,
  })
end

return M
