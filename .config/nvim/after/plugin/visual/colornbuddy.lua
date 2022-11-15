-- Filename: colornbuddy.lua
-- Last Change: Wed, 09 Nov 2022 17:08:43
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:

local status, colorbuddy = pcall(require, "colorbuddy")
if status then
	return
end

colorbuddy.colorscheme("onebuddy")
