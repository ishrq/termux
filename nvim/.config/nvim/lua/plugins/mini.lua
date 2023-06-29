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

      local go_in = "<M-l>"
      local go_out = "<M-h>"
      if vim.fn.hostname() ~= "pop-os" then
        go_in = "<Right>"
        go_out = "<Left>"
      end

      require('mini.files').setup{
        mappings = {
          close       = 'q',
          go_in       = go_in,
          go_in_plus  = '<CR>',
          go_out      = go_out,
          go_out_plus = '',
          reset       = '<BS>',
          show_help   = 'g?',
          synchronize = '=',
          trim_left   = '<',
          trim_right  = '>',
        },
      }

      -- Show/hide dot files in file tree
      local show_dotfiles = true
      local filter_show = function(fs_entry) return true end
      local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, '.')
      end
      local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        MiniFiles.refresh({ content = { filter = new_filter } })
      end
      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id
          vim.keymap.set('n', '<Leader>.', toggle_dotfiles, { buffer = buf_id })
        end,
      })

      -- Set current directory with file tree
      local files_set_cwd = function(path)
        -- Works only if cursor is on the valid file system entry
        local cur_entry_path = MiniFiles.get_fs_entry().path
        local cur_directory = vim.fs.dirname(cur_entry_path)
        vim.fn.chdir(cur_directory)
      end
      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          vim.keymap.set('n', 'cd', files_set_cwd, { buffer = args.data.buf_id })
        end,
      })

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
