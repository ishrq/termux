return {
    -- https://github.com/jose-elias-alvarez/null-ls.nvim
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = function ()
            local null_ls = require("null-ls")
            local code_actions = null_ls.builtins.code_actions
            local diagnostics = null_ls.builtins.diagnostics
            local formatting = null_ls.builtins.formatting
            local hover = null_ls.builtins.hover
            local completion = null_ls.builtins.completion

            return {
                sources = {
                    code_actions.eslint_d,
                    code_actions.gitsigns,
                    completion.luasnip,
                    completion.spell,
                    diagnostics.alex,
                    diagnostics.codespell,
                    diagnostics.eslint_d,
                    diagnostics.fish,
                    diagnostics.mdl,
                    diagnostics.phpcs,
                    diagnostics.todo_comments,
                    diagnostics.trail_space,
                    diagnostics.write_good,
                    formatting.black,
                    formatting.codespell,
                    formatting.eslint_d,
                    formatting.fish_indent,
                    formatting.jq,
                    formatting.stylua,
                    hover.dictionary,
                }
            }
        end,
    }
}
