---@diagnostic disable: undefined-global

return {
  'hrsh7th/nvim-cmp',
  config = function()
    local cmp = require 'cmp'
    local lspkind = require 'lspkind'
    local sources = {
      { name = 'luasnip' },
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'path' },
    }

    cmp.setup({
      snippet = {
        expand = function(args)
          require 'luasnip'.lsp_expand(args.body)
        end
      },
      experimental = { ghost_text = { hl_group = 'LineNr' } },
      window = {
        completion = {
          border = { "", "", "", "", "", "", "", "" },
          scrollbar = true,
        },
        documentation = {
          border = { "", "", "", "", "", "", "", "" },
          scrollbar = true,
        }
      },
      sources = sources,

      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format({
          mode = 'symbol_text',
          max_width = 70,
          ellipsis_char = '...',
          show_labelDetails = true,
          before = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        }),
      },
      mapping = cmp.mapping.preset.insert({
        ['<S-j>'] = cmp.mapping.select_next_item({ select = true }),
        ['<S-k>'] = cmp.mapping.select_prev_item({ select = true }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }),
    })

    -- when searching auto complete with words present in the buffers
    cmp.setup.cmdline('/', {
      sources = {
        { name = 'buffer' }
      }
    })

    -- when executing a command auto complete with commands and paths
    cmp.setup.cmdline(':', {
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
          { name = 'cmdline' }
        })
    })

  end,
}
