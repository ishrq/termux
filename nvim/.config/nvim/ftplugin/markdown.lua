-- Indent 2 spaces
vim.o.tabstop     = 2
vim.o.softtabstop = 2
vim.o.shiftwidth  = 2

-- character column
vim.o.cc = 81

-- MiniAi textobjects
local spec_pair = require('mini.ai').gen_spec.pair
vim.b.miniai_config = {
  custom_textobjects = {
    ['*'] = spec_pair('*', '*', { type = 'greedy' }),
    ['_'] = spec_pair('_', '_', { type = 'greedy' }),
    ['~'] = spec_pair('~', '~', { type = 'greedy' }),
    d = {{ '()%d%d%d%d[-|/]%d%d[-|/]%d%d()', '()%d%d[-|/]%d%d[-|/]%d%d%d%d()', }}, -- date
    f = { '%[%^()%d+()%]' }, -- footnote
    h = { '^#+%s().+%S()' }, -- heading
    t = { '^-%s%[()[%s|x]()%]%s' }, -- todo
    T = { '^-%s%[[%s|x]%]%s().+%S()' }, -- todo item
    u = { 'http[s]?://[^>%]%)\'"]+' }, -- url
  },
}

--NOTE: instead of 't' and 'T' for todo and todo item, use 'l' and 'L' for all lists?
--List includes todo, ordered, and unordered list,

local map = vim.keymap.set
local nxo = {'n', 'x', 'o'}
map(nxo, ']d', "<Cmd>lua MiniAi.move_cursor('left', 'i', 'd')<CR>", {desc='Next Date'})
map(nxo, '[d', "<Cmd>lua MiniAi.move_cursor('left', 'i', 'd', {search_method='prev'})<CR>", {desc='Previous Date'})
map(nxo, ']f', "<Cmd>lua MiniAi.move_cursor('left', 'i', 'f')<CR>", {desc='Next Footnote'})
map(nxo, '[f', "<Cmd>lua MiniAi.move_cursor('left', 'i', 'f', {search_method='prev'})<CR>", {desc='Previous Footnote'})
map(nxo, ']u', "<Cmd>lua MiniAi.move_cursor('left', 'i', 'u')<CR>", {desc='Next URL'})
map(nxo, '[u', "<Cmd>lua MiniAi.move_cursor('left', 'i', 'u', {search_method='prev'})<CR>", {desc='Previous URL'})

--TODO: add mapping for todo & headings
-- map(nxo, ']t', "<Cmd>lua MiniAi.move_cursor('left', 'i', 't')<CR>", {desc='Next Todo'})
-- map(nxo, '[t', "<Cmd>lua MiniAi.move_cursor('left', 'i', 't', {search_method='prev'})<CR>", {desc='Previous Todo'})
