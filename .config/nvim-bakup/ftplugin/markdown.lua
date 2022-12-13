-- Filename: markdown.lua
-- Last Change: 
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:

vim.opt_local.suffixesadd:prepend(".md")

vim.opt_local.relativenumber = false
vim.opt_local.number = false
vim.opt_local.spell = true
vim.opt_local.wrap = true
-- vim.opt_local.tabstop = 2
-- vim.opt_local.shiftwidth = 2

vim.bo.spelllang = "en_us"
-- vim.bo.textwidth = 80

vim.g["loaded_spellfile_plugin"] = 0

vim.api.nvim_buf_set_keymap(0, "n", "j", "gj", { noremap = true })
vim.api.nvim_buf_set_keymap(0, "n", "k", "gk", { noremap = true })
