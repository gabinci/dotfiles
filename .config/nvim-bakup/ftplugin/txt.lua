-- Filename: txt.lua
-- Last Change: Mon, 28 Nov 2022 - 09:49:43
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:

vim.wo.relativenumber = true
vim.wo.number = true
-- vim.wo.signcolumn = "no"
vim.opt_local.spell = false
vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>close!<cr>", { noremap = true, silent = true })
