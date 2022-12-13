local status, sidebar = pcall(require, "sidebar-nvim")
if not status then
	return
end

sidebar.setup({
	disable_default_keybindings = 0,
	bindings = {
		["q"] = function()
			require("sidebar-nvim").close()
		end,
	},
	todos = {
		icon = "",
		ignored_paths = { "~" }, -- ignore certain paths, this will prevent huge folders like $HOME to hog Neovim with TODO searching
		initially_closed = false, -- whether the groups should be initially closed on start. You can manually open/close groups later.
	},
	open = false,
	side = "left",
	initial_width = 30,
	update_interval = 1000,
	sections = { "datetime", "git", "diagnostics", "todos" },
	section_separator = "---------",
})
