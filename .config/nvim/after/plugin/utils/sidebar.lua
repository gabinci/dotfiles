local status, sidebar = pcall(require, "sidebar-nvim")
if not status then
	return
end

sidebar.setup({
	disable_default_keybindings = 0,
	bindings = nil,
	open = false,
	side = "left",
	initial_width = 30,
	hide_statusline = false,
	update_interval = 1000,
	sections = { "datetime", "git", "diagnostics" },
	section_separator = { "", "-----", "" },
	section_title_separator = { "" },
	containers = {
		attach_shell = "/bin/sh",
		show_all = true,
		interval = 5000,
	},
	datetime = {
		icon = "",
		format = "%a %b %d, %H:%M",
		clocks = {
			{
				name = "clock name", -- defaults to `tz`
				tz = "America/Fortaleza",
				offset = -8, -- this is ignored if tz is present, defaults to 0
			},
		},
	},
})
