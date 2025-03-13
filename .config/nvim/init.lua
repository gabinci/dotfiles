-- ensure leader is remaped fo lazy to work properly
vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local log = require("core.utils.log") -- Ensure this module contains log_error

local modules = {
	"core.options",
	"core.keymaps",
	"core.plugins",
	"core.autocmd",
}

local function safe_require(mods)
	for _, mod in ipairs(mods) do
		local ok, _ = pcall(require, mod)
		if not ok then
			log.log_error(mod)
		end
	end
end

safe_require(modules)
