require('auto-session').setup({
  pre_save_cmds = { 'NvimTreeClose', 'cclose', 'lua vim.notify.dismiss()' },
  post_restore_cmds = { 'NvimTreeRefresh' },
  auto_session_enabled = false,
  auto_save_enabled = true,
  auto_restore_enabled = false,
})
