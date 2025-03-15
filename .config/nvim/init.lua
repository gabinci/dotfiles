-- ensure leader is remaped for lazy to work properly
vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.maplocalleader = "\\"
vim.g.mapleader = " "

-- Schedule setting clipboard option to avoid potential issues
--TODO: make it only set the clipboard if YANKING smth
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus" -- Use the system clipboard
end)

local log = require("core.utils.log") -- Require the log module

-- List of core modules to require
local core_modules = {
  "core.options",
  "core.plugins",
  "core.autocmd",
  "core.keymaps.main_maps",
  "core.keymaps.plug_maps",
  "core.utils.modicator",
}

-- Safely require the modules and log any errors
log.safe_require(core_modules)
