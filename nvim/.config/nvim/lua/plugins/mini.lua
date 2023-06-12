return {
    -- https://github.com/echasnovski/mini.nvim
    {
        'echasnovski/mini.nvim',
        version = false,
        config = function ()

            require('mini.comment').setup()
            require('mini.cursorword').setup()
            require('mini.move').setup()
            require('mini.pairs').setup()
            require('mini.statusline').setup()

            -- require('mini.align').setup()
            -- require('mini.splitjoin').setup()

            require('mini.ai').setup{
                custom_textobjects = {
                    x = { '%f[%d]%d+' }, --number
                    d = {{ '()%d%d%d%d[-|/]%d%d[-|/]%d%d()', '()%d%d[-|/]%d%d[-|/]%d%d%d%d()', }}, --date
                    u = {{ 'https://[%www.][%S]+', 'http://[%S]+' }}, --url

                    --all lines in buffer
                    g = function()
                        local from = { line = 1, col = 1 }
                        local to = { line = vim.fn.line('$'), col = math.max(vim.fn.getline('$'):len(), 1) }
                        return { from = from, to = to }
                    end,
                }
            }

            require('mini.bracketed').setup{
                file = { suffix = '' },
                oldfile = { suffix = '' },
                undo = { suffix = '' },
                yank = { suffix = '' },
            }

            require('mini.indentscope').setup{
                draw = { animation = require('mini.indentscope').gen_animation.none() },
                symbol = "│",
            }

            require('mini.jump').setup{
                delay = { idle_stop = 10 }
            }

            require('mini.surround').setup{
                mappings = {
                    add = 'ys',
                    delete = 'ds',
                    find = '', -- Find surrounding right
                    find_left = '', -- Find surrounding (left)
                    highlight = '', -- Highlight surrounding
                    replace = 'cs', -- Replace surrounding
                    update_n_lines = '', -- Change number of lines
                    suffix_last = 'l', -- Suffix to search prev
                    suffix_next = 'n', -- Suffix to search next
                },
            }
        end
    }
}
