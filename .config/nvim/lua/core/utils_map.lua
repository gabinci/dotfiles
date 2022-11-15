-- Filename: utils_map.lua
-- Last Change: Tue, 15 Nov 2022 10:59:23
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:

local M = {}

local utils = require("core.utils")

M.betterSave = function()
	if utils.isModifiable() then
		return vim.cmd([[wq]])
	else
		print("file is readonly")
		return vim.cmd([[q!]])
	end
end

return M
