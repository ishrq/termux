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

      -- More themes available at:
      -- https://github.com/wroyca/dotfiles/tree/main/home/dot_config/nvim/colors
      -- base16-framer
      local b0 = "#181818"
      if vim.fn.hostname() ~= "pop-os" then
        b0 = "#000000"
      end
      require('mini.base16').setup {
        palette = {
          base00 = b0,
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
          base0B = "#32EEDC",
          base0C = "#ACDDFD",
          base0D = "#20BCFC",
          base0E = "#BA8CFC",
          base0F = "#B15F4A",
        }
      }

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
