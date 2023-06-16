return {
    -- https://github.com/neovim/nvim-lspconfig
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp', event = 'VeryLazy' },
            {
                'williamboman/mason-lspconfig.nvim',
                dependencies = { 'williamboman/mason.nvim', config = true },
                config = function ()
                    ensure_installed = { 'alex', 'bashls', 'codespell', 'css-lsp', 'eslint-lsp', 'eslint_d', 'html-lsp', 'marksman', 'pyright', 'stylua', 'write-good', }
                end,
            },

        },
        opts = {
            diagnostics = {
                underline = true,
                update_in_inset = false,
                severity_sort = true,
                virtual_text = { spacing = 4, source = 'if_many', prefix = '●' },
            },
            capabilities = {},
            autoformat = true,
            format_notify = false,
            format = { formatting_options = nil, timeout_ms = nil, },

            -- Language server setup
            servers = {
                bashls = {},
                cssls = {},
                cssmodules_ls = {},
                html = {},
                jsonls = {},
                marksman = {},
                phpactor = {},
                pyright = {},

                eslint = {
                    on_attach = function(client, bufnr)
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            buffer = bufnr,
                            command = 'EslintFixAll',
                        })
                    end,
                },

            }
        },
        -- setup = {},
        config = function ()
            local lspconfig = require('lspconfig')

            local lsp_defaults = lspconfig.util.default_config
            lsp_defaults.capabilities = vim.tbl_deep_extend( 'force', lsp_defaults.capabilities, require('cmp_nvim_lsp').default_capabilities())

            --Enable (broadcasting) snippet capability for completion
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            -- Map keys after lsp attaches to current buffer
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
}
