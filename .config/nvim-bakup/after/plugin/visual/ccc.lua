-- Filename: ccc.lua
-- Last Change: Wed, 09 Nov 2022 17:08:43
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:

local status, ccc = pcall(require, "ccc")
if not status then
	return
end

ccc.setup({})
