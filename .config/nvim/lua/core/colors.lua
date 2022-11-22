-- Filename: colors.lua
-- Last Change: Mon, 21 Nov 2022 22:00:34
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:

local function set(scheme)
	local status, _ = pcall(vim.cmd, "colorscheme " .. scheme)
	if not status then
		print("colorscheme " .. scheme(" not found"))
		return
	end
	require("core.themes." .. scheme)
end

-- vim.cmd("colorscheme tokyonight-day")

-- set('tokyonight')
-- set("tokyonight-night")
-- set("tokyonight-moon")
-- set("onebuddy")
-- set("gruvbuddy")
-- set("onedark")

set("catppuccin-macchiato")
