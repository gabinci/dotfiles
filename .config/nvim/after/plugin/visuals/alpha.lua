local status, alpha = pcall(require, "alpha")
if not status then
	require("core.log").log_error("alpha")
	return
end

local function button(sc, txt, keybind, keybind_opts, opts)
	local def_opts = {
		cursor = 5,
		align_shortcut = "right",
		hl_shortcut = "AlphaButtonShortcut",
		hl = "AlphaButton",
		width = 30,
		position = "center",
	}
	opts = opts and vim.tbl_extend("force", def_opts, opts) or def_opts
	opts.shortcut = sc
	local sc_ = sc:gsub("%s", ""):gsub("SPC", "<Leader>")
	local on_press = function()
		local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
		vim.api.nvim_feedkeys(key, "t", false)
	end
	if keybind then
		keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
		opts.keymap = { "n", sc_, keybind, keybind_opts }
	end
	return { type = "button", val = txt, on_press = on_press, opts = opts }
end

---@return string
local function info()
	local plugins = #vim.tbl_keys(packer_plugins) --- @diagnostic disable-line
	local v = vim.version()
	local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
	local platform = vim.fn.has("win32") == 1 and "" or ""
	return string.format(" %d   v%d.%d.%d %s  %s", plugins, v.major, v.minor, v.patch, platform, datetime)
end

---@return string
local function working_dir()
	local pwd = os.getenv("PWD")
	if pwd == os.getenv("HOME") then
		pwd = "Home"
	end
	return "@ " .. pwd
end

math.randomseed(os.time())

alpha.setup({
	layout = {
		{ type = "padding", val = 6 },
		{
			type = "text",
			val = require("core.ui.headers").random(),
			opts = { hl = "function", position = "center" },
		},
		{ type = "padding", val = 1 },
		{
			type = "text",
			val = info(),
			opts = { hl = "keyword", position = "center" },
		},
		{ type = "padding", val = 4 },
		{
			type = "group",
			val = {
				button("r", "  >  Recent Files", "<CMD>Telescope oldfiles<CR>"),
				button("f", "  >  Find File", "<CMD> Telescope find_files<CR>"),
				button("g", "  >  Find Word", "<CMD>Telescope grep_string <CR>"),
				button("s", "  >  Scripts", "<CMD>e ~/dotfiles/.local/bin/README.md |:cd %:p:h<CR>"),
				button("d", "  >  Dotfiles", "<CMD>e ~/dotfiles/.config/README.md| :cd %:p:h <CR>"),
				button("c", "  >  Nvim Configs", "<CMD>e $MYVIMRC |:cd %:p:h<CR>"),
				button("u", "  >  Update plugins", "<CMD>PackerSync<CR>"),
				button("q", "  >  Quit", "<Cmd>qa!<CR>"),
			},

			opts = { position = "center", spacing = 0 },
		},
		{ type = "padding", val = 2 },
		{
			type = "text",
			val = working_dir(),

			opts = { hl = "keyword", position = "center" },
		},
		{ type = "padding", val = 3 },
		{
			type = "text",
			val = require("alpha.fortune")(),
			opts = { hl = "number", position = "center" },
		},
	},
	opts = {
		setup = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "AlphaReady",
				desc = "Disable status and tabline for alpha",
				callback = function()
					vim.go.laststatus = 0
					vim.opt.showtabline = 0
					vim.api.nvim_buf_set_keymap(0, "n", "l", "<CR>", { silent = true })
				end,
			})
			vim.api.nvim_create_autocmd("BufUnload", {
				buffer = 0,
				desc = "Enable status and tabline after alpha",
				callback = function()
					vim.go.laststatus = 3
					vim.opt.showtabline = 2
				end,
			})
		end,
		margin = 5,
	},
})
