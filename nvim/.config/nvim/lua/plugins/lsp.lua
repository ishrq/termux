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
          ensure_installed = { 'codespell', 'marksman', 'write-good', }
        end,
      },
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_inset = false,
        severity_sort = true,
        virtual_text = { spacing = 4, source = 'if_many'},
      },
      capabilities = {},
      autoformat = true,
      format_notify = false,
      format = { formatting_options = nil, timeout_ms = nil, },

      -- Language server setup
      servers = { marksman = {}, }
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

          local opts = { buffer = ev.buf }
          vim.keymap.set('n', ',D', vim.lsp.buf.declaration, opts, {desc="LSP Declaration"})
          vim.keymap.set('n', ',d', vim.lsp.buf.definition, opts, {desc="LSP Definition"})
          vim.keymap.set('n', ',f', function() vim.lsp.buf.format { async = true } end, opts, {desc="LSP Format"})
          vim.keymap.set('n', ',h', vim.lsp.buf.hover, opts, {desc="LSP Hover"})
          vim.keymap.set('n', ',i', vim.lsp.buf.implementation, opts, {desc="LSP Implementation"})
          vim.keymap.set('n', ',rf', vim.lsp.buf.references, opts, {desc="LSP References"})
          vim.keymap.set('n', ',rn', vim.lsp.buf.rename, opts, {desc="LSP Rename"})
          vim.keymap.set('n', ',s', vim.lsp.buf.signature_help, opts, {desc="LSP Signature Help"})
          vim.keymap.set('n', ',td', vim.lsp.buf.type_definition, opts, {desc="LSP Type Definition"})
          vim.keymap.set({ 'n', 'v' }, ',ca', vim.lsp.buf.code_action, opts, {desc="LSP Code Action"})
        end,
      })
    end
  },
}
