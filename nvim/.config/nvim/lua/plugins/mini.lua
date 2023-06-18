return {
  -- https://github.com/echasnovski/mini.nvim
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function ()

      require('mini.align').setup()
      require('mini.comment').setup()
      require('mini.cursorword').setup()
      require('mini.move').setup()
      require('mini.pairs').setup()
      require('mini.statusline').setup()
      require('mini.trailspace').setup()

      require('mini.ai').setup{
        custom_textobjects = {
          D = {{ '()%d%d%d%d[-|/]%d%d[-|/]%d%d()', '()%d%d[-|/]%d%d[-|/]%d%d%d%d()', }}, -- date
          U = {{ 'https://[%www.][%S]+', 'http://[%www.][%S]+' }}, -- url
          x = { '%f[%d]%d+' }, -- number

          -- entire buffer
          B = function()
            local from = { line = 1, col = 1 }
            local to = { line = vim.fn.line('$'), col = math.max(vim.fn.getline('$'):len(), 1) }
            return { from = from, to = to }
          end,

        },
        silent = true
      }

      require('mini.base16').setup{
        palette = {
          base00 = "#131314",
          base01 = "#1f1d2e",
          base02 = "#26233a",
          base03 = "#767676",
          base04 = "#ebbcba",
          base05 = "#e0def4",
          base06 = "#f0f0f3",
          base07 = "#c5c3ce",
          base08 = "#e2e1e7",
          base09 = "#eb6f92",
          base0A = "#f6c177",
          base0B = "#ebbcba",
          base0C = "#6cccff",
          base0D = "#c4a7e7",
          base0E = "#9ccfd8",
          base0F = "#e5e5e5",
        }
      }

      require('mini.bracketed').setup{
        buffer     = { suffix = 'b', options = {} },
        comment    = { suffix = 'c', options = {} },
        conflict   = { suffix = 'x', options = {} },
        diagnostic = { suffix = 'e', options = {} },
        file       = { suffix = '', options = {} },
        indent     = { suffix = 'i', options = {} },
        jump       = { suffix = 'j', options = {} },
        location   = { suffix = 'l', options = {} },
        oldfile    = { suffix = '', options = {} },
        quickfix   = { suffix = 'q', options = {} },
        treesitter = { suffix = 't', options = {} },
        undo       = { suffix = '', options = {} },
        window     = { suffix = 'w', options = {} },
        yank       = { suffix = '', options = {} },
      }

     require('mini.hipatterns').setup{
        highlighters = {
          hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
          date      = { pattern = '%d%d%d%d[-|/]%d%d[-|/]%d%d' },
          url       = { pattern = 'http[s]://[%www.][%S]+'},
        },
      }

      require('mini.indentscope').setup{
        draw = {
          animation = require('mini.indentscope').gen_animation.none()
        },
        symbol = "│",
      }

      require('mini.jump').setup{
        delay = { idle_stop = 10 }
      }

      require('mini.splitjoin').setup{
        mappings = {
          toggle = '<Leader>x',
        },
      }

      require('mini.surround').setup{
        mappings = {
          add            = 'ys',
          delete         = 'ds',
          find           = '',
          find_left      = '',
          highlight      = '',
          replace        = 'cs',
          update_n_lines = '',
          suffix_last    = 'l',
          suffix_next    = 'n',
        },
      }
    end
  }
}
