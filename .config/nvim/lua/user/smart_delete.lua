-- Smart delete functionality
local function smart_delete(key)
	local lnum = vim.api.nvim_win_get_cursor(0)[1]
	local line = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, true)[1] or ""
	local reg = line:match("^%s*$") and '"_' or ""
	return reg .. key
end

-- Apply smart delete to specified keys
local delete_keys = { "d", "dd", "x", "c", "s", "C", "S", "X" }
for _, key in ipairs(delete_keys) do
	vim.keymap.set({ "n", "v", "x" }, key, function()
		return smart_delete(key)
	end, {
		noremap = true,
		expr = true,
		desc = "Smart delete",
	})
end
