return {
    -- https://github.com/jose-elias-alvarez/null-ls.nvim
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = 'nvim-lua/plenary.nvim',
        opts = function ()
            local null_ls = require("null-ls")
            local code_actions = null_ls.builtins.code_actions
            local diagnostics = null_ls.builtins.diagnostics
            local formatting = null_ls.builtins.formatting
            local hover = null_ls.builtins.hover
            local completion = null_ls.builtins.completion

            return {
                sources = {
                    code_actions.gitsigns,
                    completion.luasnip,
                    completion.spell,
                    diagnostics.codespell,
                    diagnostics.todo_comments,
                    diagnostics.trail_space,
                    diagnostics.write_good,
                    formatting.codespell,
                    hover.dictionary,
                }
            }
        end,
    }
}
