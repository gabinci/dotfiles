vim.loader.enable()

-- ensure leader is remaped for lazy to work properly
vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.maplocalleader = "\\"
vim.g.mapleader = " "

local modules = {
	-- core modules
	"core.keymaps",
	"core.options",
	"core.autocmd",

	-- load lazy
	"core.plugins",
	-- "core.lspconf",

	-- user modules
	"user.modicator",
	"user.smart_delete",

	-- tests
	-- "test.clipboard",
}

local safe_require = require("util.safe_require")
safe_require(modules)

local set_colorscheme = require("util.colors.set_colorscheme")
set_colorscheme.set_colorscheme("tokyonight-moon", "habamax")
