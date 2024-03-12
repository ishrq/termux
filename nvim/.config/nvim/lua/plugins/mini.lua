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
      require('mini.surround').setup()
      require('mini.trailspace').setup()

      if vim.fn.hostname() == "pop-os" then
        require('mini.fuzzy').setup()
      end

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
        n_lines = 500,
        silent = true,
      }

      require('mini.hues').setup({ background = '#000000', foreground = '#c9c5cb', saturation = 'high' })

      require('mini.basics').setup({
        options = {
          basic = true,
          extra_ui = false,
          win_borders = 'default',
        },
        mappings = {
          basic = true,
          option_toggle_prefix = '',
          windows = false,
          move_with_alt = true,
        },
        autocommands = {
          basic = true,
          relnum_in_visual_mode = false,
        },
        silent = false,
      })

      require('mini.bracketed').setup{
        buffer     = { suffix = 'b' },
        comment    = { suffix = 'c' },
        conflict   = { suffix = 'x' },
        diagnostic = { suffix = 'e' },
        file       = { suffix = '' },
        indent     = { suffix = '' },
        jump       = { suffix = 'j' },
        location   = { suffix = 'l' },
        oldfile    = { suffix = '' },
        quickfix   = { suffix = 'q' },
        treesitter = { suffix = '' },
        undo       = { suffix = '' },
        window     = { suffix = 'w' },
        yank       = { suffix = '' },
      }

      local hex_clr = {}
      if vim.fn.hostname() ~= "pop-os" then
        hex_clr = require('mini.hipatterns').gen_highlighter.hex_color()
      end

      require('mini.hipatterns').setup{
        highlighters = {
          hex_color = hex_clr,
          url       = { pattern = 'http[s]?://[^>%]%)\'"]+', group = 'Url'},

          date = {
            pattern = function(buf_id)
              if vim.bo[buf_id].filetype ~= 'text' then return nil end
              return '()%d%d%d%d[-|/]%d%d[-|/]%d%d()'
            end,
            group = 'Date'
          },

        },
      }

      require('mini.indentscope').setup{
        draw = {
          animation = require('mini.indentscope').gen_animation.none()
        },
        mappings = {
          goto_top = '',
          goto_bottom = '',
        },
        symbol = "│",
      }

      require('mini.jump').setup{
        delay = { idle_stop = 10 }
      }

      require('mini.operators').setup{
        exchange = {
          prefix = 'ge'
        }
      }

      require('mini.splitjoin').setup{
        mappings = { toggle = '<Leader>x' },
      }

    end
  }
}
