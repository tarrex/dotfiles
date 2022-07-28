local ok, autopairs = pcall(require, 'nvim-autopairs')
if not ok then return end

autopairs.setup({
  disable_filetype = { 'TelescopePrompt', 'vim' },
  disable_in_macro = true,
  disable_in_visualblock = true,
  enable_check_bracket_line = false,
  check_ts = true,
  ts_config = {
    lua = { 'string', 'source' },
    javascript = { 'string', 'template_string' },
    java = false
  }
})

local cmp_ok, cmp = pcall(require, 'cmp')
if not cmp_ok then return end

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' }}))
