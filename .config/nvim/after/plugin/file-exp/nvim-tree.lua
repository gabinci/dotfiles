-- Filename: nvim-tree.lua
-- Last Change: Mon, 21 Nov 2022 10:03:00
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

nvim_tree.setup({
	auto_reload_on_write = false,
	hijack_directories = { enable = false },
	update_cwd = true,
	diagnostics = {
		enable = true,
		show_on_dirs = false,
		icons = { hint = "", info = "", warning = "", error = "" },
	},
	ignore_ft_on_setup = {
		"startify",
		"dashboard",
		"alpha",
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	system_open = {
		cmd = nil,
		args = {},
	},
	git = {
		enable = true,
		ignore = false,
		timeout = 200,
	},
	renderer = {
		indent_markers = {
			enable = true,
			icons = {
				corner = "│",
				edge = "│",
				item = "│",
				none = " ",
			},
		},
		icons = {
			glyphs = {
				default = "",
				symlink = "",
				folder = {
					arrow_open = "▼",
					arrow_closed = "►",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "",
					staged = "S",
					unmerged = "",
					renamed = "➜",
					untracked = "U",
					deleted = "",
					ignored = "◌",
				},
			},
		},
		highlight_git = true,
		group_empty = false,
		root_folder_modifier = ":t",
	},
	filters = {
		dotfiles = false,
		custom = { "node_modules", "\\.cache" },
		exclude = {},
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
	log = {
		enable = false,
		truncate = false,
		types = {
			all = false,
			config = false,
			copy_paste = false,
			diagnostics = false,
			git = false,
			profile = false,
		},
	},
	actions = {
		use_system_clipboard = true,
		change_dir = {
			enable = true,
			global = false,
			restrict_above_cwd = false,
		},
		open_file = {
			quit_on_open = true,
			resize_window = false,
			window_picker = {
				enable = true,
				chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
				exclude = {
					filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
					buftype = { "nofile", "terminal", "help" },
				},
			},
		},
	},
	view = {
		width = 30,
		hide_root_folder = false,
		side = "left",
		number = false,
		relativenumber = false,
		signcolumn = "yes",
		preserve_window_proportions = true,

		mappings = {
			list = {
				{ key = { "l", "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
				{ key = "C", action = "cd" },
				{ key = "<C-e>", action = "edit_in_place" },
				{ key = "O", action = "edit_no_picker" },
				{ key = { "<C-]>", "<2-RightMouse>" }, action = "cd" },
				{ key = { "<C-v>", "v" }, action = "vsplit" },
				{ key = { "<C-x>", "x" }, action = "split" },
				{ key = { "<C-t>", "t" }, action = "tabnew" },
				{ key = "<", action = "prev_sibling" },
				{ key = ">", action = "next_sibling" },
				{ key = "P", action = "parent_node" },
				{ key = { "<BS>", "h" }, action = "close_node" },
				{ key = "<Tab>", action = "preview" },
				{ key = "K", action = "first_sibling" },
				{ key = "J", action = "last_sibling" },
				{ key = "I", action = "toggle_git_ignored" },
				{ key = "H", action = "toggle_dotfiles" },
				{ key = "U", action = "toggle_custom" },
				{ key = "R", action = "refresh" },
				{ key = "a", action = "create" },
				{ key = "d", action = "remove" },
				{ key = "D", action = "trash" },
				{ key = "r", action = "rename" },
				{ key = "<C-r>", action = "full_rename" },
				{ key = "x", action = "cut" },
				{ key = "c", action = "copy" },
				{ key = "p", action = "paste" },
				{ key = "y", action = "copy_name" },
				{ key = "Y", action = "copy_path" },
				{ key = "gy", action = "copy_absolute_path" },
				{ key = "[e", action = "prev_diag_item" },
				{ key = "[c", action = "prev_git_item" },
				{ key = "]e", action = "next_diag_item" },
				{ key = "]c", action = "next_git_item" },
				{ key = "-", action = "dir_up" },
				{ key = "s", action = "system_open" },
				{ key = "f", action = "live_filter" },
				{ key = "F", action = "clear_live_filter" },
				{ key = "q", action = "close" },
				{ key = "W", action = "collapse_all" },
				{ key = "E", action = "expand_all" },
				{ key = "S", action = "search_node" },
				{ key = ".", action = "run_file_command" },
				{ key = "<C-k>", action = "toggle_file_info" },
				{ key = "g?", action = "toggle_help" },
				{ key = "m", action = "toggle_mark" },
				{ key = "bmv", action = "bulk_move" },
			},
		},
	},
})
