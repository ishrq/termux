return {
  -- https://github.com/nvim-treesitter/nvim-treesitter
  { "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { "<c-space>", desc = "Increment selection" },
    { "<bs>", desc = "Decrement selection", mode = "x" },
  },
  opts = {
    auto_install = false,
    autopairs = {enable=true},
    context_commentstring = { enable=true, enable_autocmd= false },
    highlight = {enable=true},
    indent = {enable=false},
    matchup = {enable=true},
    sync_install = false,
    ensure_installed = {"bash", "fish", "lua", "markdown", "markdown_inline"},
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
-- https://github.com/nvim-treesitter/nvim-treesitter-context
{
  "nvim-treesitter/nvim-treesitter-context",
  event = "VimEnter",
  config = function()
    require('treesitter-context').setup{
      max_lines = 1;
    }
  end
}
}
