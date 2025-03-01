-- Make sure to setup `mapleader` and `maplocalleader` before lazy is called     askdlfjaklsdjlkasjdlkasjdklasjdlkasjdlkasjd
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highligh when yanking (Copying) text",
	group = vim.api.nvim_create_augroup("keickstart-highlight-yank", {clear = true}),
	callback = function()
		vim.highlight.on_yank()
	end,
})

require ("core.lazy")
require ("core.options")
require ("core.keymaps")




