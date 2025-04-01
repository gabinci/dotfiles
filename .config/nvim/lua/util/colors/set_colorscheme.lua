---@class ColorschemeModule
---@field colorschemes string[] List of available colorschemes.
---@field set_colorscheme fun(primary: Colorschemes, ...: Colorschemes) Function to set colorscheme with multiple fallbacks.

-- Require the generated type definitions
require("util.colors.colorscheme_types")

-- Fetch the list of available colorschemes
local colorschemes = vim.fn.getcompletion("", "color")

-- Create the module
local M = {}

-- Assign the list of colorschemes to the module
M.colorschemes = colorschemes

--- Sets the colorscheme with a fallback option.
---@param primary Colorschemes The primary colorscheme to use.
---@param ... Colorschemes The fallback colorschemes (variadic).
M.set_colorscheme = function(primary, ...)
	local status, _ = pcall(vim.cmd.colorscheme, primary)
	if not status then
		local fallbacks = { ... }
		for _, fallback in ipairs(fallbacks) do
			local fallback_status, _ = pcall(vim.cmd.colorscheme, fallback)
			if fallback_status then
				vim.notify(
					'Colorscheme "' .. primary .. '" not found. Using fallback "' .. fallback .. '".',
					vim.log.levels.WARN
				)
				return -- Exit after a successful fallback
			end
		end
		vim.notify('Colorscheme "' .. primary .. '" and all fallbacks not found.', vim.log.levels.ERROR)
	end
end

vim.api.nvim_create_user_command("GenerateColorTypes", function()
	local status = pcall(function()
		require("util.colors.generate_types")
	end)
	if not status then
		vim.notify("Error generating colorschemes: " .. (debug.traceback() or ""), vim.log.levels.ERROR)
	end
end, {
	desc = "Generate Colorschemes Type Definitions",
})

---@type ColorschemeModule
return M
