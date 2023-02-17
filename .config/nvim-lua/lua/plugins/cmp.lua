local cmp_ok, cmp = pcall(require, 'cmp')
if not cmp_ok then return end

local luasnip_ok, luasnip = pcall(require, 'luasnip')
if not luasnip_ok then return end

local kind_icons = {
  Text = '',
  Method = 'm',
  Function = '',
  Constructor = '',
  Field = '',
  Variable = '',
  Class = '',
  Interface = '',
  Module = '',
  Property = '',
  Unit = '',
  Value = '',
  Enum = '',
  Keyword = '',
  Snippet = '',
  Color = '',
  File = '',
  Reference = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = '',
  Event = '',
  Operator = '',
  TypeParameter = '',
}

-- local check_backspace = function()
--   local col = vim.fn.col '.' - 1
--   return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s'
-- end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local replace_termcodes = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_backspace = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

local tab_complete = function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.expand_or_jumpable() then
    vim.fn.feedkeys(replace_termcodes('<Plug>luasnip-expand-or-jump'), '')
  elseif check_backspace() then
    vim.fn.feedkeys(replace_termcodes('<Tab>'), 'n')
  else
    fallback()
  end
end

local s_tab_complete = function(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip.jumpable(-1) then
    vim.fn.feedkeys(replace_termcodes('<Plug>luasnip-jump-prev'), '')
  elseif has_words_before() then
    cmp.complete()
  else
    fallback()
  end
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
    ['<CR>'] = cmp.mapping.confirm { select = false },
    -- ['<Tab>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   elseif luasnip.expand_or_jumpable() then
    --     luasnip.expand_or_jump()
    --   elseif check_backspace() then
    --     fallback()
    --   else
    --     fallback()
    --   end
    -- end, { 'i', 's' }),
    -- ['<S-Tab>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   elseif luasnip.jumpable(-1) then
    --     luasnip.jump(-1)
    --   else
    --     fallback()
    --   end
    -- end, { 'i', 's' }),
    ['<Tab>'] = tab_complete,
    ['<S-Tab>'] = s_tab_complete,
  },

  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },

  -- window = {
  --   documentation = {
  --     border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
  --   },
  -- },

  sources = {
    { name = 'nvim_lsp' },
    -- { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lua' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
  },

  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
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

  experimental = {
    ghost_text = false,
    native_menu = false,
  },
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'cmdline' },
  })
})
