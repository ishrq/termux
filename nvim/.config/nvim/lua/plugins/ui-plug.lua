return {
    "jesseleite/nvim-noirbuddy",
    dependencies = {"tjdevries/colorbuddy.nvim", branch = "dev"},
    config = function()
        require("noirbuddy").setup {
            -- preset = 'minimal',
            preset = 'miami-nights',
            -- preset = 'kiwi',
            -- preset = 'crt-amber',
            -- preset = 'crt-green',
            -- preset = 'slate',
            colors = {
                primary = '#e4609b',
                secondary = '#6EE2FF',
                background = '#000000',
            },
            styles = {
                italic = true,
                bold = false,
                underline = false,
                undercurl = true,
            },
        }
    end
}
