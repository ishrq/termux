return {
    { "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufReadPost",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "fish", "go", "javascript", "lua", "markdown", "markdown_inline" },
                sync_install = false,
                highlight = {enable = true},
                autopairs = {enable=true},
                indent = {enable=false},
                auto_install = false,
                context_commentstring = { enable = true, enable_autocmd = false },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                      init_selection = '<CR>',
                      node_incremental = '<CR>',
                      scope_incremental = '<C-CR>',
                      node_decremental = '<BS>',
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
                          swap_next = { ['<leader>s'] = '@parameter.inner', },
                          swap_previous = { ['<leader>S'] = '@parameter.inner', },
                      },
                  },

            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPre",
        config = function() require('treesitter-context').setup{ patterns = { markdown = {} } } end
    }
}
