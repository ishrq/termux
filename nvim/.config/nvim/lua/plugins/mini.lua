return {
    {
        'echasnovski/mini.nvim',
        version = false,
        config = function ()

            require('mini.bracketed').setup()
            require('mini.comment').setup()
            require('mini.cursorword').setup()
            require('mini.jump').setup()
            require('mini.move').setup()
            require('mini.pairs').setup()

            -- require('mini.align').setup()
            -- require('mini.splitjoin').setup()

            require('mini.ai').setup{
                custom_textobjects = {
                    n = { '%f[%d]%d+' },
                    d = { '()%d%d%d%d%-%d%d%-%d%d()' },
                    g = function()
                        local from = { line = 1, col = 1 }
                        local to = {
                            line = vim.fn.line('$'),
                            col = math.max(vim.fn.getline('$'):len(), 1)
                        }
                        return { from = from, to = to }
                    end,
                }
            }

            require('mini.indentscope').setup{
                draw = { animation = require('mini.indentscope').gen_animation.none() },
                symbol = "│",
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
                    suffix_last = 'l', -- Suffix to search with "prev" method
                    suffix_next = 'n', -- Suffix to search with "next" method
                },
            }
        end
    }
}
