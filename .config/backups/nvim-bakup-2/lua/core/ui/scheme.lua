local function set(scheme)
	local status, _ = pcall(vim.cmd, "colorscheme " .. scheme)
	if not status then
		vim.notify("Failed to load" .. scheme, "error")
		return
	end
	require("core.ui.themes." .. scheme)
end

set("catppuccin-mocha")

-- vim.cmd("colorscheme tokyonight-day")
-- set('tokyonight')
-- set("tokyonight-night")
-- set("tokyonight-moon")
-- set("onebuddy")
-- set("gruvbuddy")
-- set("onedark")

require("core.ui.modicator")
