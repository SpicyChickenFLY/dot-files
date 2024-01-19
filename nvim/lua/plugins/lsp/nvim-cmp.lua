local cmp = require('cmp')
local luasnip = require('luasnip')
local icons = require('core.icons')

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local default_cmp_opts = {
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  preselect = 'none',
  completion = { completeopt = 'menu, preview, menuone, noinsert' },
  mapping = {
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-h>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<C-l>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ['<C-j>'] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
      elseif has_words_before() then cmp.complete()
      else fallback()
      end
    end, { 'i', 'c', 's', }
    ),
    ['<C-k>'] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then luasnip.jump(-1)
      else fallback()
      end
    end, { 'i', 'c', 's', }
    ),
  },
  window = {
    completion = {
      -- border = 'rounded',
      -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      scrollbar = true,
    },
    documentation = {
      border = 'rounded',
      winhighlight = "Normal:CmpDoc",
    },
  },
  experimental = {
    ghost_text = true,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'nvim_lua' },
    { name = 'cmdline' },
    { name = 'path' },
    { name = "vim-dadbod-completion" },
  }),
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(_, item)
      local icon = icons.kind_icons[item.kind]
      item.menu = item.kind
      item.kind = icon
      return item
    end,
  },
}

cmp.setup(default_cmp_opts)

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  }),
})

cmp.setup.filetype('TelescopePrompt', { enabled = false, })

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
    { { name = 'path' }, },
    { { name = 'cmdline' }, }
  ),
})

cmp.event:on(
  'confirm_done',
  require('nvim-autopairs.completion.cmp').on_confirm_done()
)

