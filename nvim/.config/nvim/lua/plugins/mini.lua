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
          x = { '%f[%d]%d+' }, -- number

          -- entire buffer
          B = function()
            local from = { line = 1, col = 1 }
            local to = { line = vim.fn.line('$'), col = math.max(vim.fn.getline('$'):len(), 1) }
            return { from = from, to = to }
          end,

        },
        silent = true,
      }
      require('mini.base16').setup{
        -- framer
        palette = {
          base00 = "#181818",
          base01 = "#151515",
          base02 = "#464646",
          base03 = "#747474",
          base04 = "#B9B9B9",
          base05 = "#D0D0D0",
          base06 = "#E8E8E8",
          base07 = "#EEEEEE",
          base08 = "#FD886B",
          base09 = "#FC4769",
          base0A = "#FECB6E",
          base0B = "#32CCDC",
          base0C = "#ACDDFD",
          base0D = "#20BCFC",
          base0E = "#BA8CFC",
          base0F = "#B15F4A",
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
          hex_color = require('mini.hipatterns').gen_highlighter.hex_color(), --hex color
          date      = { pattern = '()%d%d%d%d[-|/]%d%d[-|/]%d%d()' },
          url       = { pattern = 'https://[%www.][%S]+', 'http://[%S]+'},
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
