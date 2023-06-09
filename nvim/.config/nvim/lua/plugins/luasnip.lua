return {
    {
        "L3MON4D3/LuaSnip",
        event = 'InsertEnter',
        dependencies = {"rafamadriz/friendly-snippets" },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
        keys = {
            { "<c-n>", "<Plug>luasnip-next-choice", mode = { "i", "s"} },
            { "<c-p>", "<Plug>luasnip-prev-choice", mode = { "i", "s" } },
            { "<tab>", function() return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>" end, expr = true, silent = true, mode = "i", },
            { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
            { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load({ exclude = {"html"} })
            require("luasnip.loaders.from_lua").lazy_load()

            local ls = require("luasnip")
            local snip = ls.snippet
            -- local node = ls.snippet_node
            -- local text = ls.text_node
            local insert = ls.insert_node
            -- local func = ls.function_node
            local choice = ls.choice_node
            -- local dynamic = ls.dynamic_node
            -- local r = ls.restore_node
            -- local l = require("luasnip.extras").lambda
            -- local rep = require("luasnip.extras").rep
            -- local p = require("luasnip.extras").partial
            -- local m = require("luasnip.extras").match
            -- local n = require("luasnip.extras").nonempty
            -- local dl = require("luasnip.extras").dynamic_lambda
            local fmt = require("luasnip.extras.fmt").fmt
            -- local fmta = require("luasnip.extras.fmt").fmta
            -- local types = require("luasnip.util.types")
            -- local conds = require("luasnip.extras.conditions")
            -- local conds_expand = require("luasnip.extras.conditions.expand")

            ls.add_snippets("fish", {
                snip("fun", fmt("function {}\n\t{}\nend\n\n{}", {insert(1, "func_name"), insert(2), insert(0)})),

                snip("switch", fmt("switch ${}\n\tcase '{}'{}\nend\n\n{}", {insert(1, "arg"), insert(2, "case"), insert(3), insert(0)})),

                snip("case", fmt("case '{}'{}", {insert(1, "case"), insert(0)})),

                snip("if", fmt("if {}\n\t{}\nend\n\n{}", {insert(1, "condition"), insert(2), insert(0)})),

                snip("set", fmt("set {} '{}' \n{}", {insert(1, "var"), insert(2, "value"), insert(0) })),
            })

            ls.add_snippets("markdown", {

                snip("permanote", fmt("---\nType: Permanent Note\nTopic: {}\nTitle: {}\nRelated: {}\n---\n\n{}", {insert(1, "CS"), insert(2, "Title"), insert(3), insert(0) } )),

                snip("rel", fmt("[[./{}]]", {insert(1),})),
                snip("src", fmt("Source\n---\n{}", {insert(1),})),

                snip("litnote", fmt("---\nType: Literature Note\n{}\n---\n\n{}", {choice(1, {
                    fmt("Book: {}\nAuthor: {}", {insert(1, "Title"), insert(2, "Author")}),
                    fmt("Article: [{}]({})\n", {insert(1, "Title"), insert(2, "URL")}),
                    fmt("Podcast: [{}]({})\n", {insert(1, "Title"), insert(2, "URL")}),
                    fmt("Video: [{}]({})\n", {insert(1, "Title"), insert(2, "URL")}), }), insert(0) } )),
            })

        end
    }
}
