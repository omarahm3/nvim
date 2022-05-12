local cmp_status_ok, cmp = pcall(require, 'cmp')

if not cmp_status_ok then
  vim.notify('CMP was not loaded')
  return
end

local snip_status_ok, luasnip = pcall(require, 'luasnip')

if not snip_status_ok then
  vim.notify('LuaSnip was not loaded')
  return
end

require 'luasnip/loaders/from_vscode'.lazy_load()

local check_backspace = function()
  local col = vim.fn.col '.' - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s'
end

--   פּ ﯟ   some other good icons
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

-- find more here: https://www.nerdfonts.com/cheat-sheet
local source_mapping = {
  cmp_tabnine = MrGeek.icons.ribbon,
  copilot = MrGeek.icons.light,
  nvim_lsp = MrGeek.icons.paragraph .. '[LSP]',
  nvim_lua = MrGeek.icons.bomb,
  luasnip = MrGeek.icons.snippet,
  buffer = MrGeek.icons.buffer,
  path = MrGeek.icons.folderOpen2,
}

local format = function(entry, vim_item)
  -- Kind icons
  vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
  vim_item.menu = source_mapping[entry.source.name]
  return vim_item
end


local present, lspkind = pcall(require, 'lspkind')

-- In case LSPKind is available then configure CMP to use it
if present then
  format = function(entry, vim_item)
    vim_item.kind = lspkind.symbolic(vim_item.kind, { with_text = true })
    local menu = source_mapping[entry.source.name]
    local maxwidth = 50

    vim_item.menu = menu
    vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)

    return vim_item
  end
end

local default = {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
  },
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = format,
  },
  sources = {
    { name = 'cmp_tabnine' },
    { name = 'copilot' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
  sorting = {
    comparators = {
      cmp.config.compare.exact,
      cmp.config.compare.locality,
      cmp.config.compare.recently_used,
      cmp.config.compare.score,
      cmp.config.compare.offset,
      cmp.config.compare.sort_text,
      cmp.config.compare.order,
    },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    completion = cmp.config.window.bordered({
      winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder"
    }),
    documentation = cmp.config.window.bordered({
      winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder"
    }),
  },
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
}

-- `/` cmdline setup.
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
-- `:` cmdline setup.
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

local M = {}

M.setup = function()
  cmp.setup(default)
end

vim.cmd("au InsertChange * lua require('copilot.utils').send_completion_request()")

return M
