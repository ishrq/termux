-- Author: IA
-- Machine: S8

--AUTOCOMMAND

local augroup = vim.api.nvim_create_augroup  --Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd  --Create autocommand

augroup('bufcheck', {clear = true})

-- reload config file on change
autocmd('BufWritePost', {
  group   = 'bufcheck',
  pattern = vim.env.MYVIMRC,
  command = 'silent source %'})

-- highlight yanks
autocmd('TextYankPost', {
  group    = 'bufcheck',
  pattern  = '*',
  callback = function() vim.highlight.on_yank{timeout=300} end })

-- remove whitespace on write
autocmd('BufWritePre', {
  pattern = '*',
  command = ":%s/\\s\\+$//e" })

-- don't auto comment new lines
autocmd('BufEnter', {
  pattern = '*',
  command = 'set fo-=c fo-=r fo-=o' })

-- resume previous position
autocmd('BufReadPost', {
  pattern = '*',
  command = [[ if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]], })

-- auto create directory on save
-- https://jdhao.github.io/2022/08/21/you-do-not-need-a-plugin-for-this/
autocmd('BufWritePre', {
  pattern = "*",
  group = augroup("auto_create_dir", { clear = true }),
  callback = function(ctx)
    local dir = vim.fn.fnamemodify(ctx.file, ":p:h")
    vim.fn.mkdir(dir, "p")
  end
})


--Markdown/gitcommit
autocmd('FileType', {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})


--SKELETON

--ledger
autocmd('BufNewFile', {
 pattern = '*/Finance/Ledger/ledger*.txt',
 command = '0r ~/.config/nvim/skeletons/ledger.txt' })

--html
autocmd('BufNewFile', {
 pattern = '*.html',
 command = '0r ~/.config/nvim/skeletons/html-skeleton.html' })
