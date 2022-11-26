-- current file path: after/plugin/visual/bufferline.lua
-- last change: Fri, 25 Nov 2022 - 21:22:24
-- Author: gabinci

local status, bufferline = pcall(require, "bufferline")
if not status then
	return
end

bufferline.setup({
	options = {
		hover = {
			enabled = true,
			delay = 200,
			reveal = { "close" },
		},

		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				separator = true,
			},
		},

		sort_by = "directory",
		separator_style = "thin",
		enforce_regular_tabs = true,

		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level)
			local icon = level:match("error") and " " or ""
			return " " .. icon .. count
		end,

		custom_areas = {
			right = function()
				local result = {}
				local seve = vim.diagnostic.severity
				local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
				local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
				local info = #vim.diagnostic.get(0, { severity = seve.INFO })
				local hint = #vim.diagnostic.get(0, { severity = seve.HINT })
				if error ~= 0 then
					table.insert(result, { text = "  " .. error, fg = "#EC5241" })
				end

				if warning ~= 0 then
					table.insert(result, { text = "  " .. warning, fg = "#EFB839" })
				end

				if hint ~= 0 then
					table.insert(result, { text = "  " .. hint, fg = "#A3BA5E" })
				end

				if info ~= 0 then
					table.insert(result, { text = "  " .. info, fg = "#7EA9A7" })
				end
				return result
			end,
		},
	},
})

-- BufferLineCyclePrev
-- BufferLineCycleNex
