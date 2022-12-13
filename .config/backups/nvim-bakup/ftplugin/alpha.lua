-- Filename: alpha.lua
-- Last Change: 
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:
vim.opt.list = false
vim.cmd([[ autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2 ]])
vim.api.nvim_buf_set_keymap(0, "n", "l", "<CR>", { silent = true })
