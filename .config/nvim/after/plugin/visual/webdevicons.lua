local status_icons, icons = pcall(require, "nvim-web-devicons")
if not status_icons then
	return
end

icons.setup({
	override = {
		zsh = {
			icon = "",
			color = "#A6DA95",
			cterm_color = "2",
			name = "Zsh",
		},
		snippet = {
			icon = "",
			color = "#F5BDE6",
			cterm_color = "5",
			name = "Snippet",
		},
		sh = {
			icon = "",
			color = "#EED49F",
			cterm_color = "6",
		},
	},
	-- globally enable different highlight colors per icon (default to true)
	-- if set to false all icons will have the default icon's color
	color_icons = true,
	-- globally enable default icons (default to false)
	-- will get overriden by `get_icons` option
	default = true,
})
