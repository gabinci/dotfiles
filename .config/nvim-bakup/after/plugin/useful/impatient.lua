-- Filename: impatient.lua
-- Last Change: Wed, 09 Nov 2022 17:08:43
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:

_G.__luacache_config = {
	chunks = {
		enable = true,
		path = vim.fn.stdpath("cache") .. "/luacache_chunks",
	},
	modpaths = {
		enable = true,
		path = vim.fn.stdpath("cache") .. "/luacache_modpaths",
	},
}

local status, impatient = pcall(require, "impatient")
if not status then
	return
end

impatient.enable_profile()
