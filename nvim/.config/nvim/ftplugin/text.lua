-- Indent 2 spaces
vim.o.tabstop     = 2
vim.o.softtabstop = 2
vim.o.shiftwidth  = 2

-- Mini.ai textobjects
local spec_pair = require('mini.ai').gen_spec.pair
vim.b.miniai_config = {
    custom_textobjects = {
        d = {{ '()%d%d%d%d[-|/]%d%d[-|/]%d%d()', '()%d%d[-|/]%d%d[-|/]%d%d%d%d()', }}, -- date
        u = { 'http[s]?://[^>%]%)\'"]+' }, -- url
    },
}

local map = vim.keymap.set
local nxo = {'n', 'x', 'o'}
map(nxo, ']d', "<Cmd>lua MiniAi.move_cursor('left', 'i', 'd', {n_lines='200'})<CR>", {desc='Next date'})
map(nxo, '[d', "<Cmd>lua MiniAi.move_cursor('left', 'i', 'd', {search_method='prev', n_lines='200'})<CR>", {desc='Previous date'})
map(nxo, ']u', "<Cmd>lua MiniAi.move_cursor('left', 'i', 'u', {n_lines='200'})<CR>", {desc='Next url'})
map(nxo, '[u', "<Cmd>lua MiniAi.move_cursor('left', 'i', 'u', {search_method='prev', n_lines='200'})<CR>", {desc='Previous url'})

-- MiniBracketed
vim.b.minibracketed_config = {
  treesitter = { suffix = '' },
}
