local ok, installer = pcall(require, 'nvim-lsp-installer')
if not ok then return end

installer.settings({
  ui = {
    icons = {
      server_installed = '◍',
      server_pending = '◍',
      server_uninstalled = '◍',
    },
    keymaps = {
      toggle_server_expand = '<CR>',
      install_server = 'i',
      update_server = 'u',
      update_all_servers = 'U',
      uninstall_server = 'X',
    },
  },

  install_root_dir = string.format('%s/lsp_servers', vim.fn.stdpath('data')),

  pip = {
    install_args = {},
  },
  log_level = vim.log.levels.WARN,
  max_concurrent_installers = 4,
})

installer.on_server_ready(function(server)
  local opts = {}
  server:setup(opts)
end)
