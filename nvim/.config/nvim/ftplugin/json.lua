-- json pretty print
vim.keymap.set('n', '<C-p>', ':%!jq .<CR>')

-- on pressing 'o' to create a new line
-- append comma ',' at end of previous line
-- https://github.com/JoosepAlviste/dotfiles/blob/master/config/nvim/ftplugin/json.lua

vim.keymap.set('n', 'o', function()
  local line = vim.api.nvim_get_current_line()

  local should_add_comma = string.find(line, '[^,{[]$')
  if should_add_comma then
    return 'A,<cr>'
  else
    return 'o'
  end
end, { buffer = true, expr = true })
