local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not ok then return end

treesitter.setup({
  ensure_installed = {
    'go', 'python', 'rust', 'c', 'lua',
    'html', 'css', 'scss', 'javascript', 'typescript'
  },
  highlight = {
    enable = true,
    disable = function(lang, buf)
      local max_filesize = 1024 * 1024 -- 1 MB
      local ok_stats, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok_stats and stats and stats.size > max_filesize then
        return true
      end
    end,
  }
})
