return {
    --Colorscheme: https://github.com/rebelot/kanagawa.nvim
    {
        'rebelot/kanagawa.nvim',
        name = 'kanagawa',
        config = function ()
            require('kanagawa').setup{
                dimInactive = true,
                colors = {
                    palette = { dragonBlack3 = "#000000" },
                    theme = {
                        all = { ui = { bg_gutter = "none", } }
                    }
                },
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        NormalFloat = { bg = "none" },
                        FloatBorder = { bg = "none" },
                        FloatTitle = { bg = "none" },
                        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
                        -- Popular plugins that open floats
                        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

                        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend },
                        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                        PmenuSbar = { bg = theme.ui.bg_m1 },
                        PmenuThumb = { bg = theme.ui.bg_p2 },
                    }
                end,
            }
            require('kanagawa').load('dragon') --wave, lotus, dragon
        end
    }
}
