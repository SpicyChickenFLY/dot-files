require('auto-session').setup({
  pre_save_cmds = { 'NvimTreeClose', 'cclose' },
  post_restore_cmds = { 'NvimTreeRefresh' },
  auto_session_enabled = true,
  auto_save_enabled = true,
  auto_restore_enabled = true,
})
