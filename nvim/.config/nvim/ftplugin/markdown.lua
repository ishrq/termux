-- Indent 2 spaces
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2


-- markdown-preview.nvim
vim.keymap.set('n', '<C-p>', '<Plug>MarkdownPreviewToggle', {desc='Markdown Preview'})


-- MiniAi textobjects

local spec_pair = require('mini.ai').gen_spec.pair
vim.b.miniai_config = {
  -- TODO: add textobject for footnotes & tasks
  custom_textobjects = {
    ['*'] = spec_pair('*', '*', { type = 'greedy' }),
    ['_'] = spec_pair('_', '_', { type = 'greedy' }),
    ['~'] = spec_pair('~', '~', { type = 'greedy' }),
    d = {{ '()%d%d%d%d[-|/]%d%d[-|/]%d%d()', '()%d%d[-|/]%d%d[-|/]%d%d%d%d()', }}, -- date
    u = {{ 'https://[%www.][%S]+', 'http://[%www.][%S]+' }}, -- url
  },
}

vim.keymap.set({'n','x','o'}, ']d', "<Cmd>lua MiniAi.move_cursor('left', 'i', 'd', {n_lines='200'})<CR>", {desc='Next date'})
vim.keymap.set({'n','x','o'}, '[d', "<Cmd>lua MiniAi.move_cursor('left', 'i', 'd', {search_method='prev', n_lines='200'})<CR>", {desc='Previous date'})
vim.keymap.set({'n','x','o'}, ']u', "<Cmd>lua MiniAi.move_cursor('left', 'i', 'u', {n_lines='200'})<CR>", {desc='Next url'})
vim.keymap.set({'n','x','o'}, '[u', "<Cmd>lua MiniAi.move_cursor('left', 'i', 'u', {search_method='prev', n_lines='200'})<CR>", {desc='Previous url'})


-- MiniBracketed
vim.b.minibracketed_config = {
  treesitter = { suffix = '' },
}
