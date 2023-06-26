return{
  -- https://github.com/tzachar/highlight-undo.nvim
  {
    'tzachar/highlight-undo.nvim',
    config = function()
      require('highlight-undo').setup()
    end
  },
}
