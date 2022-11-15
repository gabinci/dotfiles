-- Filename: bufferline.lua
-- Last Change: 
-- vim:set ft=lua nolist softtabstop=2 shiftwidth=2 tabstop=2 expandtab:

local status, bufferline = pcall(require, "bufferline")
if not status then
	return
end

bufferline.setup({
	options = {
		numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
		left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
		middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
		indicator_icon = nil,
		indicator = { style = "icon", icon = "▎" },
		-- indicator = { style = "underline" },
		buffer_close_icon = "",
		-- buffer_close_icon = '',
		modified_icon = "●",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 18,
		max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
		tab_size = 18,
		diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
		diagnostics_update_in_insert = true,
		offsets = {
			{
				filetype = "NvimTree",
				text = "NVIM TREE",
				text_align = "center",
				separator = true,
			},
		},

		show_buffer_icons = true,
		show_buffer_close_icons = true,
		show_close_icon = false,
		show_tab_indicators = true,
		persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
		separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
		enforce_regular_tabs = true,
		always_show_bufferline = true,
	},

	highlights = {
		-- fill = {
		-- 	fg = "#bbc2cf",
		-- 	bg = "#202328",
		-- },
	},
})

-- bufferline.setup({
-- 	options = {
-- 		keymap = {
-- 			normal_mode = {},
-- 		},
-- 		highlights = {
-- 			background = {
-- 				italic = true,
-- 			},
-- 			buffer_selected = {
-- 				bold = true,
-- 			},
-- 		},
-- 		options = {
-- 			mode = "buffers", -- set to "tabs" to only show tabpages instead
-- 			numbers = "none", -- can be "none" | "ordinal" | "buffer_id" | "both" | function
-- 			close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
-- 			right_mouse_command = "vert sbuffer %d", -- can be a string | function, see "Mouse actions"
-- 			left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
-- 			middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
-- 			indicator = {
-- 				icon = "▎", -- this should be omitted if indicator style is not 'icon'
-- 				style = "icon", -- can also be 'underline'|'none',
-- 			},
-- 			modified_icon = "●",
-- 			buffer_close_icon = "",
-- 			left_trunc_marker = "",
-- 			right_trunc_marker = "",
-- 			close_icon = "",
-- 			name_formatter = function(buf)
-- 				if buf.name:match("%.md") then
-- 					return vim.fn.fnamemodify(buf.name, ":t:r")
-- 				end
-- 			end,
-- 			max_name_length = 18,
-- 			max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
-- 			truncate_names = true, -- whether or not tab names should be truncated
-- 			tab_size = 18,
-- 			diagnostics = "nvim_lsp",
-- 			diagnostics_update_in_insert = false,
-- 			offsets = {
-- 				{ filetype = "NvimTree", text = "", padding = 1 },
-- 				{
-- 					filetype = "undotree",
-- 					text = "",
-- 					padding = 1,
-- 				},
-- 				{
-- 					filetype = "NvimTree",
-- 					text = "",
-- 					padding = 1,
-- 				},
-- 				{
-- 					filetype = "DiffviewFiles",
-- 					text = "",
-- 					padding = 1,
-- 				},
-- 				{
-- 					filetype = "flutterToolsOutline",
-- 					text = "",
-- 					highlight = "PanelHeading",
-- 				},
-- 				{
-- 					filetype = "packer",
-- 					text = "",
-- 					highlight = "PanelHeading",
-- 					padding = 1,
-- 				},
-- 			},
-- 			color_icons = true, -- whether or not to add the filetype icon highlights
-- 			show_buffer_icons = true,
-- 			show_buffer_close_icons = true,
-- 			show_close_icon = false,
-- 			show_tab_indicators = true,
-- 			persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
-- 			separator_style = "thin",
-- 			enforce_regular_tabs = false,
-- 			always_show_bufferline = false,
-- 			hover = {
-- 				enabled = false,
-- 				delay = 200,
-- 				reveal = { "close" },
-- 			},
-- 			sort_by = "id",
-- 		},
-- 	},
-- })
