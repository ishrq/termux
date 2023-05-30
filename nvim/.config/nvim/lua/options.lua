-- Author: IA
-- Machine: S8


local opt = vim.o


--CONTEXT
opt.number         = true
opt.numberwidth    = 3
opt.relativenumber = false
opt.ruler          = true
opt.scrolloff      = 4
opt.sidescrolloff  = 4
opt.signcolumn     = 'auto'

--FILETYPE
opt.encoding     = 'utf-8'
opt.fileencoding = 'utf-8'
opt.termencoding = 'utf-8'

--THEME
opt.syntax = 'on'
opt.termguicolors = true

--WHITESPACE
opt.expandtab   = true
opt.tabstop     = 4
opt.softtabstop = 4
opt.shiftwidth  = 4

--SPLITS
opt.splitbelow = 1
opt.splitright = 1

--INDENT
opt.autoindent  = true
opt.breakindent = true
opt.smartindent = true

--WRAP
opt.lbr  = true
opt.wrap = true

--GENERAL
opt.autoread    = true
opt.ch          = 0
opt.clipboard   = "unnamedplus" --system clipboard
opt.cursorline  = true
opt.foldenable  = true
opt.foldlevel   = 99
opt.foldmethod  = 'indent' --manual, indent, syntax, expr, marker
opt.grepprg     = 'rg' --default grep
opt.ls          = 0
opt.lazyredraw  = true
opt.mouse       = 'a'
opt.showmatch   = true --highlight [{()}]
opt.spo         = 'noplainbuffer' --no spellcheck in code
opt.timeoutlen  = 1000 --key timeout
opt.undofile    = true --save undo history
opt.updatetime  = 250  --decrease update time
-- opt.wbr = "%f"


--SEARCH
-- opt.hlsearch    = false
opt.ignorecase  = true
opt.incsearch   = true
opt.smartcase   = true

--Fuzzy search
-- vim.opt.pathappend('**') --search subdir
opt.wmnu = true --tab complete


--borrowed https://this-week-in-neovim.org/2023/Jan/09

local ns = vim.api.nvim_create_namespace('toggle_hlsearch')

local function toggle_hlsearch(char)
  if vim.fn.mode() == 'n' then
    local keys = { '<CR>', 'n', 'N', '*', '#', '?', '/' }
    local new_hlsearch = vim.tbl_contains(keys, vim.fn.keytrans(char))

    if vim.opt.hlsearch:get() ~= new_hlsearch then
      vim.opt.hlsearch = new_hlsearch
    end
  end
end

vim.on_key(toggle_hlsearch, ns)
