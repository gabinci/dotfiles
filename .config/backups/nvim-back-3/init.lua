-- ░▀█▀░█▀█░▀█▀░▀█▀░░░░█░░░█░█░█▀█
-- ░░█░░█░█░░█░░░█░░░░░█░░░█░█░█▀█
-- ░▀▀▀░▀░▀░▀▀▀░░▀░░▀░░▀▀▀░▀▀▀░▀░▀

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("core.lazy")
require("core.keymaps")
require("core.options")
require("core.autocmd")
