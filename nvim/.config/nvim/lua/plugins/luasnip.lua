return {
    {
        "L3MON4D3/LuaSnip",
        event = 'InsertEnter',
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
            require("luasnip.loaders.from_lua").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load()

            local ls = require("luasnip")
            local snip = ls.snippet
            local insert = ls.insert_node
            local choice = ls.choice_node
            local fmt = require("luasnip.extras.fmt").fmt

            ls.add_snippets("markdown", {
                snip("litnote", fmt("---\nType: Literature Note\n{}\n---\n\n{}", {choice(1, {
                    fmt("Book: {}\nAuthor: {}", {insert(1, "Title"), insert(2, "Author")}),
                    fmt("Article: [{}]({})\n", {insert(1, "Title"), insert(2, "URL")}),
                    fmt("Podcast: [{}]({})\n", {insert(1, "Title"), insert(2, "URL")}),
                    fmt("Video: [{}]({})\n", {insert(1, "Title"), insert(2, "URL")}), }), insert(0) } )),
            })

        end
    }
}
