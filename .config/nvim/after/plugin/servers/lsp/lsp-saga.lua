local status, saga = pcall(require, "lspsaga")
if not status then
	vim.notify("Failed to load LSPsaga")
	return
end

saga.init_lsp_saga({
	move_in_saga = { prev = "<C-k", next = "<C-j" },
	finder_action_keys = {
		open = "<CR>",
	},
	definition_action_keys = {
		edit = "<CR>",
	},
})
