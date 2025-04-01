local function generate_colorschemes()
	local colorschemes = vim.fn.getcompletion("", "color")
	local output = "-- auto-generated file.  Do not edit.\n"
	output = output .. "---@alias Colorschemes\n"
	for _, scheme in ipairs(colorschemes) do
		output = output .. '---| "' .. scheme .. '"\n'
	end

	local file = io.open("lua/util/colors/colorscheme_types.lua", "w")
	if not file then
		vim.notify("Error opening file for writing: colorscheme_types.lua", vim.log.levels.ERROR)
		return
	end
	file:write(output)
	file:close()
	vim.notify("Generated colorschemes type definitions.", vim.log.levels.INFO)
end

generate_colorschemes()
