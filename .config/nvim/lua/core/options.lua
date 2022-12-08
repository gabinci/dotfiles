-- Filename: options.lua
-- Last Change: Sat, 03 Dec 2022 - 21:14:20
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:
--
--  ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ ███████╗
-- ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ ██╔════╝
-- ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗███████╗
-- ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║╚════██║
-- ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝███████║
--  ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ ╚══════╝

vim.cmd("autocmd!")
local o = vim.opt

-- indent options
o.breakindent = true
o.smartindent = true
o.shiftround = true
o.autoindent = true
o.expandtab = true
o.smarttab = true
o.tabstop = 2
o.shiftwidth = 2

-- search options
o.ignorecase = true
o.incsearch = true
o.smartcase = true
o.hlsearch = true

---- performance settings
o.lazyredraw = true

---- text rendering options
vim.scriptencoding = "utf-8"
o.fileencoding = "utf-8"
o.encoding = "utf-8"
o.linebreak = true
o.wrap = false
o.sidescrolloff = 8
o.scrolloff = 8

---- user interface options
o.relativenumber = true
o.termguicolors = true
o.inccommand = "split"
-- vim.opt.cursorcolumn   = true
-- vim.opt.background     = 'dark'
o.showtabline = 2
o.signcolumn = "yes"
o.cursorline = true
o.splitbelow = true
o.splitright = true
o.laststatus = 0
o.cmdheight = 1
o.winblend = 0
o.pumblend = 5
o.showmode = false
o.showcmd = true
o.number = true
o.ruler = true
o.title = true
o.mouse = "a"
-- o.background     = 'dark'

---- code folding
o.foldnestmax = 3
o.foldmethod = "indent"
o.foldenable = false

---- miscellaneous options
o.backspace = "indent,eol,start"
o.clipboard = "unnamedplus"
o.swapfile = false
o.autoread = true
o.undofile = true
o.history = 1000
o.confirm = true
o.backup = false
o.hidden = true
o.spell = false
o.exrc = true
o.equalalways = false

-- o.filetype = "on"
o.iskeyword:append("-")
o.shortmess:append("c")
o.keywordprg = ":help"

vim.cmd([[set wildignore+=.pyc,.swp]])
-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
