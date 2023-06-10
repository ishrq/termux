return {
    {
        'Everblush/nvim',
        name = 'everblush',
        config = function ()
            require("everblush").setup{
                override = {
                    Normal = {
                        bg = '#000000',
                    }
                }
            }
            vim.cmd.colorscheme("everblush")
        end
    },
}

-- this is a comment
