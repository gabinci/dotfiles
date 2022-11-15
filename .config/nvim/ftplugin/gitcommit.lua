-- Filename: gitcommit.lua
-- Last Change: Wed, 09 Nov 2022 18:21:36
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:

vim.wo.relativenumber = false
vim.wo.number = true
vim.wo.signcolumn = "no"
vim.wo.scrolloff = 0
vim.opt_local.wrap = true
vim.opt_local.spell = true
vim.opt_local.buflisted = false
vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>close!<cr>", { noremap = true, silent = true })
