-- Filename: lua.lua
-- Last Change: Wed, 09 Nov 2022 18:24:06
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:

-- local opt_local = vim.opt_local
-- vim.opt_local.includeexpr , _ = vim.v.fname:gsub('%.', '/')
vim.cmd([[ setlocal includeexpr=substitute(v:fname,'\\.','/','g') ]])
vim.opt_local.suffixesadd:prepend(".lua")
vim.opt_local.suffixesadd:prepend("init.lua")
vim.opt_local.spell = false
vim.opt_local.list = false
vim.bo.path = vim.bo.path .. "," .. vim.fn.stdpath("config") .. "/lua"

vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
-- vim.bo.textwidth = 78
vim.bo.expandtab = true
