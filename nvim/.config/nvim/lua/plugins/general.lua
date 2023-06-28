return{
  -- https://github.com/nvim-lua/plenary.nvim
  {
    'nvim-lua/plenary.nvim',
    lazy = true,
  },
  -- https://github.com/tzachar/highlight-undo.nvim
  {
    'tzachar/highlight-undo.nvim',
    lazy = true,
    keys = {
      { 'u', 'undo', {}},
      { '<C-r>', 'redo', {}},
    },
    config = true
  },
}
