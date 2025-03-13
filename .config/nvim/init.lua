-- Ensure leader key is remapped for lazy.nvim to work properly
vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Import the log module to handle error logging
local log = require("core.utils.log")

-- List of modules to be safely required
local modules = {
	"core.options", -- Core options settings
	"core.keymaps", -- Keymaps configurations
	"core.plugins", -- Plugin configurations
	"core.autocmd", -- Auto-command configurations
}

-- Function to safely require modules and log any errors
local function safe_require()
	for _, mod in ipairs(modules) do
		-- Attempt to require the module and catch any errors
		local ok, err = pcall(require, mod)
		if not ok then
			-- If loading the module fails, log the error
			log.log_error(mod .. ": " .. err)
		end
	end
end

-- Call the function to safely require all necessary modules
safe_require()
