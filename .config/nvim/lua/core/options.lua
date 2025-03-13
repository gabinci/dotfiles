vim.cmd("autocmd!") -- Clear all autocommands to prevent unexpected behaviors
vim.g.have_nerd_font = true -- Indicate that NERD fonts are available

asldjkasd
-- Function to load default options
local load_default_options = function()
	-- Check if Neovim is running in headless mode (without a UI)
	if #vim.api.nvim_list_uis() == 0 then
		-- Headless mode settings
		vim.opt.shortmess = "" -- Prevent 'echom' from truncating messages
		vim.opt.more = false -- Disable pausing when the screen is filled
		vim.opt.cmdheight = 9999 -- Avoid 'hit-enter' prompts
		vim.opt.columns = 9999 -- Set the widest possible screen
		vim.opt.swapfile = false -- Disable swap file creation
		return
	end
	-- Standard mode settings
	local default_options = {
		breakindent = true, -- Enable break indent
		smartindent = true, -- Enable smart indenting
		shiftround = true, -- Round indent to multiple of 'shiftwidth'
		autoindent = true, -- Copy indent from current line when starting a new line
		smarttab = true, -- Insert 'shiftwidth' spaces when pressing <Tab>
		incsearch = true, -- Show search matches as you type
		linebreak = true, -- Wrap lines at convenient points
		relativenumber = true, -- Show relative line numbers
		inccommand = "split", -- Show effects of command incrementally in a split
		winblend = 0, -- No transparency for floating windows
		pumblend = 5, -- Slight transparency for the popup menu
		foldenable = false, -- Disable code folding by default
		backspace = "indent,eol,start", -- Allow backspacing over everything in insert mode
		autoread = true, -- Automatically read files when changed outside of Neovim
		history = 1000, -- Keep 1000 lines of command-line history
		confirm = true, -- Confirm before exiting unsaved changes
		spell = false, -- Disable spell checking
		exrc = true, -- Allow project-specific vimrc files
		equalalways = false, -- Don't resize windows automatically
		keywordprg = ":help", -- Use :help for K command
		backup = false, -- Disable backup file creation
		cmdheight = 1, -- Command-line height
		completeopt = { "menuone", "noselect" }, -- Completion options
		conceallevel = 0, -- Show all text normally
		fileencoding = "utf-8", -- File encoding
		foldmethod = "manual", -- Manual code folding
		foldexpr = "", -- No fold expression
		guifont = "monospace:h17", -- GUI font
		hidden = true, -- Allow buffer switching without saving
		hlsearch = true, -- Highlight search matches
		ignorecase = true, -- Case-insensitive search
		pumheight = 10, -- Popup menu height
		showmode = false, -- Don't show mode in command line
		showtabline = 2, -- Always show tab line
		smartcase = true, -- Override 'ignorecase' if search pattern contains uppercase letters
		splitbelow = true, -- Horizontal splits open below
		splitright = true, -- Vertical splits open to the right
		swapfile = false, -- Disable swap file creation
		termguicolors = true, -- Enable 24-bit RGB colors
		timeoutlen = 300, -- Time to wait for a mapped sequence to complete (in milliseconds)
		title = true, -- Set window title
		undofile = true, -- Enable persistent undo
		updatetime = 250, -- Faster completion
		writebackup = false, -- Disable backup before overwriting a file
		expandtab = true, -- Convert tabs to spaces
		shiftwidth = 2, -- Number of spaces for each indentation
		tabstop = 2, -- Number of spaces that a <Tab> counts for
		cursorline = true, -- Highlight the current line
		number = true, -- Show line numbers
		numberwidth = 4, -- Width of the line number column
		signcolumn = "yes", -- Always show the sign column
		wrap = false, -- Disable line wrapping
		scrolloff = 10, -- Minimum number of lines to keep above and below the cursor
		sidescrolloff = 10, -- Minimum number of columns to keep to the left and right of the cursor
		showcmd = false, -- Disable command display in the last line of the screen
		ruler = false, -- Disable the ruler
		laststatus = 3, -- Global status line
		list = false, -- Disable displaying unprintable characters
		listchars = { tab = "» ", trail = "·", nbsp = "␣" }, -- Characters to show for tabs, trailing spaces, and non-breaking spaces
		shortmess = "cI", -- Suppress completion messages and intro text
		spelllang = "cjk", -- Disable spellchecking for Asian characters
		whichwrap = "<,>,[,],h,l", -- Allow cursor to move to the next/previous line with certain keys
		-- iskeyword = "-", -- Treat hyphenated words as a single word
	}

	-- Apply the options
	for k, v in pairs(default_options) do
		vim.opt[k] = v
	end
end

--- OTHER SETINGS --
-- Schedule setting clipboard option to avoid potential issues
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus" -- Use the system clipboard
end)

vim.scriptencoding = "utf-8" -- Set script encoding to UTF-8

-- Wildmenu settings
vim.cmd([[set wildignore+=.pyc,.swp]]) -- Ignore certain file types in file completion

-- Undercurl settings for terminal
vim.cmd([[let &t_Cs = "\e[4:3m"]]) -- Enable undercurl
vim.cmd([[let &t_Ce = "\e[4:0m"]]) -- Disable undercurl

load_default_options() -- Load the default options
