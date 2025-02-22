local status, lspsaga = pcall(require, "lspsaga")
if not status then
	require("core.log").log_error("lspsaga")
	return
end

lspsaga.init_lsp_saga({
	move_in_saga = { prev = "<C-k", next = "<C-j" },
	finder_action_keys = {
		open = "<CR>",
	},
	definition_action_keys = {
		edit = "<CR>",
	},
})
