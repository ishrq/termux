return {
    -- https://github.com/neovim/nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp', event = 'VeryLazy' },
            { 'williamboman/mason-lspconfig.nvim', dependencies = { 'williamboman/mason.nvim', config = true }, },
        },
        opts = {
            -- vim.diagnostic.config
            diagnostics = {
                underline = true,
                update_in_inset = false,
                severity_sort = true,
                virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
            },
            -- auto format on save
            autoformat = true,
            format_notify = false,
            format = { formatting_options = nil, timeout_ms = nil, },
        },
        config = function ()

            -- Language server setup

            local lspconfig = require('lspconfig')

            lspconfig.bashls.setup{} --Bash
            lspconfig.cssls.setup{capabilities=capabilities} --CSS
            lspconfig.cssmodules_ls.setup{} --CSS Modules
            lspconfig.html.setup{capabilities=capabilities} --HTML
            -- lspconfig.jsonls.setup{capabilities = capabilities} --Json
            -- lspconfig.phpactor.setup{} --PHP
            -- lspconfig.pylsp.setup{} --Python
            lspconfig.vale_ls.setup{} --Vale
            -- lspconfig.clangd.setup{} --C
            -- lspconfig.golangci_lint_ls.setup{} --Go
            -- lspconfig.sqlls.setup{} --SQL
            -- lspconfig.tailwindcss.setup{} --Tailwind CSS
            -- lspconfig.tsserver.setup{} --Typescript

            -- JS
            lspconfig.eslint.setup{
                on_attach = function(client, bufnr)
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        command = "EslintFixAll",
                    })
                end,
            }

            -- Lua
            -- lspconfig.lua_ls.setup {
            --     settings = {
            --         Lua = {
            --             runtime = { version = 'LuaJIT', },
            --             diagnostics = { globals = {'vim'}, },
            --             workspace = { library = vim.api.nvim_get_runtime_file("", true), },
            --             telemetry = { enable = false, },
            --         },
            --     },
            -- }

            local lsp_defaults = lspconfig.util.default_config

            lsp_defaults.capabilities = vim.tbl_deep_extend( 'force', lsp_defaults.capabilities, require('cmp_nvim_lsp').default_capabilities())

            --Enable (broadcasting) snippet capability for completion
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            local on_attach_custom = function(client, bufnr)
                local function buf_set_option(name, value) vim.api.nvim_buf_set_option(bufnr, name, value) end

                buf_set_option('omnifunc', 'v:lua.MiniCompletion.completefunc_lsp')

                -- Currently all formatting is handled with 'null-ls' plugin
                if vim.fn.has('nvim-0.8') == 1 then
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                else
                    client.resolved_capabilities.document_formatting = false
                    client.resolved_capabilities.document_range_formatting = false
                end
            end

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
}
