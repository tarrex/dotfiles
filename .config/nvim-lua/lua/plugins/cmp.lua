local ok, cmp = pcall(require, 'cmp')
if not ok then return end

local luasnip = require('luasnip')
local lspkind = require('lspkind')

-- local timer = vim.loop.new_timer()

-- function DebounceCMP(delay)
--   timer:stop()
--   timer:start(delay, 0, vim.schedule_wrap(function()
--     cmp.complete({ reason = cmp.ContextReason.Auto })
--   end))
-- end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = {
    ['<C-e>'] = cmp.mapping{
      i = cmp.mapping.abort(),
      c = cmp.mapping.abort(),
    },
    ['<Esc>'] = cmp.mapping{
      i = cmp.mapping.close(),
      c = cmp.mapping.close(),
    },
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behaviour = cmp.SelectBehavior.Select })
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end, { 'i', 'c' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behaviour = cmp.SelectBehavior.Select })
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end, { 'i', 'c' })
  },

  completion = {
    -- completeopt = 'menu,menuone,noselect',
    -- autocomplete = false,
    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lua' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer', keyword_length = 5 },
  },

  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol',
      maxwidth = 50,
      menu = {
        nvim_lsp = '[LSP]',
        nvim_lsp_signature_help = '[SIG]',
        nvim_lua = '[LUA]',
        luasnip = '[SNP]',
        path = '[PTH]',
        buffer = '[BUF]',
      }
    })
  }
})

-- vim.cmd([[
--   augroup CmpDebounceAuGroup
--     au!
--     au TextChangedI * lua DebounceCMP(500)
--   augroup end
-- ]])

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
