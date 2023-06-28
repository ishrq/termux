return {
  -- https://github.com/neovim/nvim-lspconfig
  {
    'neovim/nvim-lspconfig',
    cond = vim.fn.hostname() == 'pop-os',
    dependencies = {
      {
        'williamboman/mason.nvim',
        cmd = 'Mason',
      },
       {
         'williamboman/mason-lspconfig.nvim',
         cond = vim.fn.hostname() == 'pop-os',
       },
    },
    config = function()
      if vim.fn.hostname() == 'pop-os' then
        vim.api.nvim_create_autocmd('LspAttach', {
          desc = 'LSP actions',
          callback = function(event)
            local map = function(keys, func, desc)
              if desc then
                desc = "LSP: " .. desc
              end

              vim.keymap.set('n', keys, func, { buffer = bufnr, remap = false, desc = desc })
            end

            map(',ca', vim.lsp.buf.code_action, "Code Action")
            map(',rn', vim.lsp.buf.rename, "Rename")
            map('gd', vim.lsp.buf.definition, "Goto Definition")
            map('gD', vim.lsp.buf.declaration, "Goto Declaration")
            map(',gr', vim.lsp.buf.references, "Goto References")
            map(',gi', vim.lsp.buf.implementation, "Goto Implementation")
            map(',td', vim.lsp.buf.type_definition, "Type Definition")
            map('K', vim.lsp.buf.hover, "Hover Documentation")
            map('<C-k>', vim.lsp.buf.signature_help, "Signature Documentation")
            map('<C-f>', function() vim.lsp.buf.format { async = true } end, "Format")
            map(',wa', vim.lsp.buf.add_workspace_folder, "Workspace Add Folder")
            map(',wr', vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder")
            map(',wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "Workspace List Folder")
          end
        })
      end

      require('mason').setup()

      if vim.fn.hostname() == 'pop-os' then
        require('mason-lspconfig').setup({
          ensure_installed = {
            'bashls',
            'clangd',
            'cssls',
            'denols',
            'html',
            'lua_ls',
            'marksman',
            'pyright',
            'tailwindcss',
          }
        })

        local lspconfig = require('lspconfig')
        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

        require('mason-lspconfig').setup_handlers({
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = lsp_capabilities,
            })
          end,
        })

        require 'lspconfig'.lua_ls.setup {
          Lua = {
            runtime = { version = 'LuaJIT', },
            diagnostics = { globals = { 'vim' }, },
            workspace = { library = vim.api.nvim_get_runtime_file('', true), },
            telemetry = { enable = false, },
          },
        }

        -- Edit lsp diagnostics signs (in margin)
        local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = "󰋽 " }
        for type, icon in pairs(signs) do
          local hl = "DiagnosticSign" .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        -- Edit inline diagnostic preferences
        vim.diagnostic.config({
          virtual_text = {
            prefix = "",
          },
          severity_sort = true,
          float = {
            source = "always",
          },
        })
      end
    end
  },
  -- https://github.com/hrsh7th/nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    event = "InsertEnter",
    dependencies = {
      {
        'hrsh7th/cmp-nvim-lsp',
        cond = vim.fn.hostname() == 'pop-os'
      },
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require("cmp")

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")

      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        sources = {
          { name = 'path' },
          { name = 'luasnip',  keyword_length = 1 },
          { name = 'buffer',   keyword_length = 2 },
          { name = 'nvim_lsp', keyword_length = 2 },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered()
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-Space>"] = cmp.mapping.complete(),

          -- Super tab
          ["<Esc>"] = cmp.mapping(function(fallback)
            luasnip.unlink_current()
            fallback()
          end),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then cmp.complete()
            else fallback() end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            else fallback() end
          end, {'i', 's'}),
        }),
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype({ 'markdown' }, {
        sources = cmp.config.sources({ { name = 'path' } }, { { name = 'luasnip' } }, { { name = 'buffer' } })
      })

      -- Disable completion in comments
      cmp.setup({
        enabled = function()
          local context = require 'cmp.config.context'
          -- keep command mode completion enabled when cursor is in a comment
          if vim.api.nvim_get_mode().mode == 'c' then
            return true
          else
            return not context.in_treesitter_capture("comment")
            and not context.in_syntax_group("Comment")
          end
        end
      })
    end
  },
  -- https://github.com/L3MON4D3/LuaSnip
  {
    'L3MON4D3/LuaSnip',
    lazy = true,
    event = 'InsertEnter',
    opts = {
      history = true,
      delete_check_events = 'TextChanged',
    },
    keys = {
      { "<c-n>", "<Plug>luasnip-next-choice", mode = { "i", "s"} },
      { "<c-p>", "<Plug>luasnip-prev-choice", mode = { "i", "s" } },
      { "<tab>", function() return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>" end, expr = true, silent = true, mode = "i", },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
    config = function()
      require('luasnip.loaders.from_snipmate').lazy_load()
      require('luasnip.loaders.from_lua').lazy_load()
    end
  },
  -- https://github.com/jose-elias-alvarez/null-ls.nvim
  {
    'jose-elias-alvarez/null-ls.nvim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = function()
      local null_ls = require('null-ls')
      local code_actions = null_ls.builtins.code_actions
      local diagnostics = null_ls.builtins.diagnostics
      local formatting = null_ls.builtins.formatting
      local hover = null_ls.builtins.hover
      local completion = null_ls.builtins.completion

      return {
        sources = {
          completion.luasnip,
          completion.spell,
          diagnostics.todo_comments,
          diagnostics.trail_space,
          hover.dictionary,

          code_actions.gitsigns,
          diagnostics.write_good,

          diagnostics.codespell,
          formatting.codespell,
        }
      }
    end,
  },
}
