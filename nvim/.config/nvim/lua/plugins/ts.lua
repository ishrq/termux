return {
    { "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    keys = {
        { "<c-space>", desc = "Increment selection" },
        { "<bs>", desc = "Decrement selection", mode = "x" },
    },
    opts = {
        highlight = {enable = true},
        autopairs = {enable = true},
        indent = {enable = false},
        sync_install = false,
        auto_install = false,
        context_commentstring = { enable = true, enable_autocmd = false },
        ensure_installed = {
            "bash",
            "fish",
            "html",
            "css",
            "javascript",
            "lua",
            "markdown",
            "markdown_inline",
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = '<c-space>',
                node_incremental = '<c-space>',
                scope_incremental = false,
                node_decremental = '<bs>',
            },
        },
        query_linter = {
            enable = true,
            use_virtual_text = true,
            lint_events = { "BufWrite", "CursorHold" },
        },
        textsubjects = {
            enable = true,
            keymaps = {
                ["."] = "textsubjects-smart",
                [";"] = "textsubjects-container-outer",
            },
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ['aa'] = '@parameter.outer',
                    ['ia'] = '@parameter.inner',
                    ['af'] = '@function.outer',
                    ['if'] = '@function.inner',
                    ['ac'] = '@class.outer',
                    ['ic'] = '@class.inner',
                },
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    [']m'] = '@function.outer',
                    [']]'] = '@class.outer',
                },
                goto_next_end = {
                    [']M'] = '@function.outer',
                    [']['] = '@class.outer',
                },
                goto_previous_start = {
                    ['[m'] = '@function.outer',
                    ['[['] = '@class.outer',
                },
                goto_previous_end = {
                    ['[M'] = '@function.outer',
                    ['[]'] = '@class.outer',
                },
            },
            swap = {
                enable = true,
                swap_next = { ['<leader>a'] = '@parameter.inner', },
                swap_previous = { ['<leader>A'] = '@parameter.inner', },
            },
        },
    },
    --@param opts TSConfig
    config = function(_, opts)
        if type(opts.ensure_installed) == "table" then
            ---@type table<string, boolean>
            local added = {}
            opts.ensure_installed = vim.tbl_filter(function(lang)
                if added[lang] then
                    return false
                end
                added[lang] = true
                return true
            end, opts.ensure_installed)
        end
        require("nvim-treesitter.configs").setup(opts)
    end
},
{
    "nvim-treesitter/nvim-treesitter-context",
    event = "VimEnter",
    config = true
}
}
