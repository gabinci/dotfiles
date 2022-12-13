
-- Filename: colors.lua
-- Last Change: Sat, 03 Dec 2022 - 19:08:42
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:

local function set(scheme)
	local status, _ = pcall(vim.cmd, "colorscheme " .. scheme)
	if not status then
		vim.notify("colorscheme " .. scheme(" not found"))
		return
	end
	require("core.theming.themes." .. scheme)
end

-- vim.cmd("colorscheme tokyonight-day")

-- set('tokyonight')
-- set("tokyonight-night")
-- set("tokyonight-moon")
-- set("onebuddy")
-- set("gruvbuddy")
-- set("onedark")

set("catppuccin-mocha")
