local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath) -- Add lazy to the `runtimepath`, this allows us to `require` it.
local _, lazy = pcall(require, "lazy")
if not _ then
	print("Lazy.nvim not found!")
	return
end

lazy.setup(
	{ import = "plug" }, -- Set up lazy, and load my `lua/plug` folder
	{
		install = { colorscheme = { "tokyonight", "habamax" } },
		change_detection = {
			notify = false,
		},
	}
)
