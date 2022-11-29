local Logger = {}
Logger.__index = Logger


Logger = {}
Logger.__index = Logger

local function log(type, msg, opts)
  local ok, notify = pcall(require, 'notify')
  if ok then
    opts  = vim.tbl_deep_extend('force', { title = 'NeverVim', }, opts)
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

function Logger:log(msg, opts)
  log(vim.log.levels.INFO, msg, opts or {})
end
function Logger:warn(msg, opts)
  log(vim.log.levels.WARN, msg, opts or {})
end
function Logger:error(msg, opts)
  log(vim.log.levels.ERROR, msg, opts or {})
end

return Logger
