local M = {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = "hrsh7th/cmp-nvim-lsp",
    pin = true,
}

function M.config()
    local lspconfig = require('lspconfig')
    local lsp_defaults = lspconfig.util.default_config

    lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
    )

    -- SERVER

    -- C
    -- require'lspconfig'.clangd.setup{}

    -- Go
    require'lspconfig'.golangci_lint_ls.setup{}

    -- Lua
    --[[ require'lspconfig'.sumneko_lua.setup {
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim'},
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
    } ]]


    -- Json
    -- require'lspconfig'.jsonls.setup{}

    -- Python
    -- require'lspconfig'.pylsp.setup{}

    -- Pyright
    -- require'lspconfig'.pyright.setup{}

    -- Ruby
    -- require'lspconfig'.ruby_ls.setup{}

    -- Rust
    -- require'lspconfig'.rust_analyzer.setup{}

    -- SQL
    -- require'lspconfig'.sqlls.setup{}

    -- Typescript
    -- require'lspconfig'.tsserver.setup{}



    -- LSP Attach

    vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function()
            local bufmap = function(mode, lhs, rhs)
                local opts = {buffer = true}
                vim.keymap.set(mode, lhs, rhs, opts)
            end

            -- Displays hover information about the symbol under the cursor
            bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

            -- Jump to the definition
            bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

            -- Jump to declaration
            bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

            -- Lists all the implementations for the symbol under the cursor
            bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

            -- Jumps to the definition of the type symbol
            bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

            -- Lists all the references
            bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

            -- Displays a function's signature information
            bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

            -- Renames all references to the symbol under the cursor
            bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

            -- Selects a code action available at the current cursor position
            bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
            bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

            -- Show diagnostics in a floating window
            bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

            -- Move to the previous diagnostic
            bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

            -- Move to the next diagnostic
            bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
        end
    })
end

return M
