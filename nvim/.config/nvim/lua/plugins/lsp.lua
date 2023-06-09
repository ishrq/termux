return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            { 'williamboman/mason-lspconfig.nvim', dependencies = { 'williamboman/mason.nvim', config = true }, },
        },
        opts = {
            -- vim.diagnostic.config
            diagnostics = {
                underline = true,
                update_in_inset = false,
                severity_sort = true,
                virtual_text = {
                    spacing = 4,
                    source = "if_many",
                    prefix = "●"
                },
            },
            -- auto format on save
            autoformat = true,
            format_notify = false,
            format = {
                formatting_options = nil,
                timeout_ms = nil,
            },
        },
        config = function()
            local lspconfig = require('lspconfig')
            local lsp_defaults = lspconfig.util.default_config

            lsp_defaults.capabilities = vim.tbl_deep_extend( 'force', lsp_defaults.capabilities, require('cmp_nvim_lsp').default_capabilities())

            --Enable (broadcasting) snippet capability for completion
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            -- SERVER

            -- CSS
            lspconfig.cssls.setup{
                capabilities = capabilities,
            }

            -- HTML
            lspconfig.html.setup{
                capabilities = capabilities,
            }

            -- JS
            lspconfig.eslint.setup{
                on_attach = function(client, bufnr)
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        command = "EslintFixAll",
                    })
                end,
            }

            -- Json
            lspconfig.jsonls.setup{
                capabilities = capabilities,
            }

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings.
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
                    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
                end,
            })
        end
    },
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
                    diagnostics.phpcs,
                    diagnostics.todo_comments,
                    diagnostics.trail_space,
                    diagnostics.write_good,
                    formatting.codespell,
                    formatting.eslint_d,
                    formatting.fish_indent,
                    formatting.jq,
                    hover.dictionary,
                }
            }
        end,
    },
}

