---@diagnostic disable
vim.cmd("autocmd!")
vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local load_default_options = function()
	local default_options = {
		breakindent = true,
		smartindent = true,
		shiftround = true,
		autoindent = true,
		smarttab = true,
		incsearch = true,
		lazyredraw = true,
		linebreak = true,
		relativenumber = true,
		inccommand = "split",
		winblend = 0,
		pumblend = 5,
		foldenable = false,
		backspace = "indent,eol,start",
		autoread = true,
		history = 1000,
		confirm = true,
		spell = false,
		exrc = true,
		equalalways = false,
		keywordprg = ":help",
		backup = false, -- creates a backup file
		clipboard = "unnamedplus", -- allows neovim to access the system clipboard
		cmdheight = 1, -- more space in the neovim command line for displaying messages
		completeopt = { "menuone", "noselect" },
		conceallevel = 0, -- so that `` is visible in markdown files
		fileencoding = "utf-8", -- the encoding written to a file
		foldmethod = "manual", -- folding, set to "expr" for treesitter based folding
		foldexpr = "", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
		guifont = "monospace:h17", -- the font used in graphical neovim applications
		hidden = true, -- required to keep multiple buffers and open multiple buffers
		hlsearch = true, -- highlight all matches on previous search pattern
		ignorecase = true, -- ignore case in search patterns
		mouse = "a", -- allow the mouse to be used in neovim
		pumheight = 10, -- pop up menu height
		showmode = false, -- we don't need to see things like -- INSERT -- anymore
		showtabline = 2, -- always show tabs
		smartcase = true, -- smart case
		splitbelow = true, -- force all horizontal splits to go below current window
		splitright = true, -- force all vertical splits to go to the right of current window
		swapfile = false, -- creates a swapfile
		termguicolors = true, -- set term gui colors (most terminals support this)
		timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
		title = true, -- set the title of window to the value of the titlestring
		undofile = true, -- enable persistent undo
		updatetime = 100, -- faster completion
		writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
		expandtab = true, -- convert tabs to spaces
		shiftwidth = 2, -- the number of spaces inserted for each indentation
		tabstop = 2, -- insert 2 spaces for a tab
		cursorline = true, -- highlight the current line
		number = true, -- set numbered lines
		numberwidth = 4, -- set number column width to 2 {default 4}
		signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
		wrap = false, -- display lines as one long line
		scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor.
		sidescrolloff = 8, -- minimal number of screen lines to keep left and right of the cursor.
		showcmd = false,
		ruler = false,
		laststatus = 3,
		list = true,
	}

	---  SETTINGS  ---
	vim.opt.listchars:append("space:⋅")
	-- vim.opt.listchars:append("eol:↴")
	vim.opt.spelllang:append("cjk") -- disable spellchecking for asian characters (VIM algorithm does not support it)
	vim.opt.shortmess:append("c") -- don't show redundant messages from ins-completion-menu
	vim.opt.shortmess:append("I") -- don't show the default intro message
	vim.opt.whichwrap:append("<,>,[,],h,l")
	vim.opt.iskeyword:append("-")
	vim.scriptencoding = "utf-8"

	---  COMMANDS  ---
	vim.cmd([[set wildignore+=.pyc,.swp]])

	-- Undercurl
	vim.cmd([[let &t_Cs = "\e[4:3m"]])
	vim.cmd([[let &t_Ce = "\e[4:0m"]])

	for k, v in pairs(default_options) do
		vim.opt[k] = v
	end
end

local load_headless_options = function()
	vim.opt.shortmess = "" -- try to prevent echom from cutting messages off or prompting
	vim.opt.more = false -- don't pause listing when screen is filled
	vim.opt.cmdheight = 9999 -- helps avoiding |hit-enter| prompts.
	vim.opt.columns = 9999 -- set the widest screen possible
	vim.opt.swapfile = false -- don't use a swap file
end

local load_defaults = function()
	if #vim.api.nvim_list_uis() == 0 then
		load_headless_options()
		return
	end
	load_default_options()
end

load_defaults()
