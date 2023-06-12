--Set <Space> as leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Define map function
local map = vim.keymap.set
local def = { noremap = true, silent = true }

-- General
map("v", ".", ":normal .<CR>", {desc="Visual mode dot repeat"})
map('i', '<c-z>', '<C-g>u<Esc>[S1z=`]a<c-g>u', {desc="Fix spelling"})
map("n", "<leader>=", ":set spell!<cr>", {desc="Toggle spell check"})
map("n", "<leader>8", ':execute "set cc=" . (&cc == "" ? "80" : "")<cr>', def, {desc="Toggle character column"})
map("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {desc="Replace current word"})
map("n", "<leader>x", ":!chmod +x %<CR>", def, { desc ="Make executable"})

-- Better indenting
map("v", "<", "<gv^")
map("v", ">", ">gv^")

-- Register
map("", "gp", "`[v`]", def, {desc="Select pasted"})
map("x", "<leader>p", [["_dP]], {desc="Paste on selection"})

-- Command mode movement
map("c", "<c-n>", "<down>")
map("c", "<c-p>", "<up>")
map("c", "<c-f>", "<right>")
map("c", "<c-b>", "<left>")

-- Insert mode movement
map("i", "<c-h>", "<left>")
map("i", "<c-l>", "<right>")

-- Move through line breaks
map({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", {expr=true, silent=true })
map({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", {expr=true, silent=true })

-- Less cursor movement
map("", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map('n', '{', '{zz')
map('n', '}', '}zz')
map('v', 'y', 'ygv<ESC>')

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- Tabs, windows, frequent files
map("n", ",k", ":tab drop ~/.config/nvim/lua/keymaps.lua<cr>", {desc="Open keymap.lua"})
map('n', '<leader>th', '<CMD>tabmove -1<CR>', {desc = "Shift to previous tab"})
map('n', '<leader>tl', '<CMD>tabmove +1<CR>', {desc = "Shift to next tab"})

-- Diagnostic keymaps
map('n', '<leader>e', vim.diagnostic.open_float)
map('n', '<leader>q', vim.diagnostic.setloclist, def)

-- mini.nvim: mini.ai
map('n', 'sa', "<cmd>lua MiniAi.move_cursor('left', 'i', 'a')<cr>", def, {desc="Next argument"})
map('n', 'Sa', "<cmd>lua MiniAi.move_cursor('left', 'i', 'a', {search_method='prev'})<cr>", def, {desc="Previous argument"})
map('n', 'sd', "<cmd>lua MiniAi.move_cursor('left', 'i', 'd')<cr>", def, {desc="Next date"})
map('n', 'Sd', "<cmd>lua MiniAi.move_cursor('left', 'i', 'd', {search_method='prev'})<cr>", def, {desc="Previous date"})
map('n', 'sf', "<cmd>lua MiniAi.move_cursor('left', 'i', 'f')<cr>", def, {desc="Next function"})
map('n', 'Sf', "<cmd>lua MiniAi.move_cursor('left', 'i', 'f', {search_method='prev'})<cr>", def, {desc="Previous function"})
map('n', 'su', "<cmd>lua MiniAi.move_cursor('left', 'i', 'u')<cr>", def, {desc="Next url"})
map('n', 'Su', "<cmd>lua MiniAi.move_cursor('left', 'i', 'u', {search_method='prev'})<cr>", def, {desc="Previous url"})
