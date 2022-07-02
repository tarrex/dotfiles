local ok, cmp = pcall(require, 'cmp')
if not ok then return end

local luasnip = require('luasnip')

-- local timer = vim.loop.new_timer()

-- function DebounceCMP(delay)
--   timer:stop()
--   timer:start(delay, 0, vim.schedule_wrap(function()
--     cmp.complete({ reason = cmp.ContextReason.Auto })
--   end))
-- end

local icons = {
  Text = '',
  Method = '',
  Function = '',
  Constructor = '⌘',
  Field = 'ﰠ',
  Variable = '',
  Class = 'ﴯ',
  Interface = '',
  Module = '',
  Property = 'ﰠ',
  Unit = '塞',
  Value = '',
  Enum = '',
  Keyword = '廓',
  Snippet = '',
  Color = '',
  File = '',
  Reference = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = 'פּ',
  Event = '',
  Operator = '',
  TypeParameter = '',
}

local codicons = {
  Text = ' ',
  Method = ' ',
  Function = ' ',
  Constructor = ' ',
  Field = ' ',
  Variable = ' ',
  Class = ' ',
  Interface = ' ',
  Module = ' ',
  Property = ' ',
  Unit = ' ',
  Value = ' ',
  Enum = ' ',
  Keyword = ' ',
  Snippet = ' ',
  Color = ' ',
  File = ' ',
  Reference = ' ',
  Folder = ' ',
  EnumMember = ' ',
  Constant = ' ',
  Struct = ' ',
  Event = ' ',
  Operator = ' ',
  TypeParameter = ' ',
}

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = {
    ['<Esc>'] = cmp.mapping{
      i = cmp.mapping.abort(),
      c = cmp.mapping.abort(),
    },
    ['<C-e>'] = cmp.mapping{
      i = cmp.mapping.close(),
      c = cmp.mapping.close(),
    },
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },

  completion = {
    -- completeopt = 'menu,menuone,noselect',
    -- autocomplete = false,
    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
  },

  sources = {
    { name = 'nvim_lsp', max_item_count = 10 },
    { name = 'nvim_lsp_signature_help', max_item_count = 10 },
    { name = 'nvim_lua', max_item_count = 10 },
    { name = 'luasnip', max_item_count = 5 },
    { name = 'path', max_item_count = 5 },
    { name = 'buffer', keyword_length = 5 },
  },

  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      local icons_ = codicons or icons
      vim_item.menu = vim_item.kind
      vim_item.kind = icons_[vim_item.kind]
      vim_item.menu = ({
        nvim_lsp = '[LSP]',
        nvim_lua = '[LUA]',
        path = '[PTH]',
        luasnip = '[SNP]',
        dictionary = '[DIC]',
        buffer = '[BUF]',
        spell = '[SPL]',
        cmdline = '[CMD]',
        cmdline_history = '[HST]',
      })[entry.source.name]

      return vim_item
    end,
  },
})

-- vim.cmd([[
--   augroup CmpDebounceAuGroup
--     au!
--     au TextChangedI * lua DebounceCMP(500)
--   augroup end
-- ]])

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer', max_item_count = 10 },
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path', max_item_count = 10 },
    { name = 'cmdline', max_item_count = 10 },
  })
})
