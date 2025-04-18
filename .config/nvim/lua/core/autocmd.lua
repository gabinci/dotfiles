local fn = vim.fn
local augroups = {}
-- local autocmd = vim.api.nvim_create_autocmd
-- local utils = require("core.utils.general")

augroups.insert = {
	toggle_search_highlighting = {
		event = { "InsertEnter", "InsertLeave" },
		pattern = "*",
		callback = function(event)
			if event.event == "InsertEnter" then
				-- Entering insert mode: check if search was active, then clear it
				if vim.v.hlsearch == 1 then
					vim.b._search_was_active = true
					vim.opt_local.hlsearch = false
					vim.fn.clearmatches()
				else
					vim.b._search_was_active = false
				end
			elseif event.event == "InsertLeave" then
				-- Leaving insert mode: restore only if it was previously cleared
				if vim.b._search_was_active then
					vim.opt_local.hlsearch = true
				end
			end
		end,
	},

	match_extra_spaces = {
		event = "InsertLeave",
		pattern = "*",
		command = [[
		highlight RedundantSpaces cterm=underline gui=underline
		match RedundantSpaces /\s\+$/
	]],
	},

	center_screen = {
		event = "InsertEnter",
		pattern = "*",
		command = "normal zz",
	},

	disable_paste = {
		event = "InsertLeave",
		pattern = "*",
		command = "set nopaste",
	},
}

augroups.toggle_cursorline = {

	enable_cursorline = {
		event = { "VimEnter", "WinEnter", "BufWinEnter" },
		pattern = "*",
		callback = function()
			vim.opt.cursorline = true
		end,
	},

	disable_cursorline = {
		event = "WinLeave",
		pattern = "*",
		command = [[set nocursorline]],
	},
}

augroups.yankpost = {
	highlight_yank = {
		event = "TextYankPost",
		pattern = "*",
		callback = function()
			-- vim.highlight.on_yank({ higroup = "Visual", timeout = 300, on_visual = true })
			vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300, on_visual = true })
		end,
	},

	yank_restore_cursor = {
		event = "TextYankPost",
		pattern = "*",
		callback = function()
			local cursor = vim.fn.getpos(".")
			if vim.v.event.operator == "y" then
				vim.fn.setpos(".", Cursor_pos)
			end
		end,
	},
}

augroups.buffer = {
	-- Buf Write
	-- {{{
	-- buf wirite pre
	mkdir_before_saving = {
		event = { "BufWritePre", "FileWritePre" },
		pattern = "*",
		callback = function(ctx)
			vim.fn.mkdir(vim.fn.fnamemodify(ctx.file, ":p:h"), "p")
		end,
	},

	-- change_header = {
	-- 	event = "BufWritePre",
	-- 	pattern = "*",
	-- 	callback = function()
	-- 		utils.changeHeader()
	-- 	end,
	-- },

	-- buf wire post

	-- make_scripts_executable = {
	-- 	event = "BufWritePost",
	-- 	pattern = "*.sh,*.py,*.zsh",
	-- 	callback = function()
	-- 		local file = vim.fn.expand("%p")
	-- 		local status = utils.is_executable()
	-- 		if status ~= true then
	-- 			vim.fn.setfperm(file, "rwxr-x---")
	-- 		end
	-- 	end,
	-- },
	-- }}}

	-- buf Enter
	disable_new_line_comments = {
		event = "BufEnter",
		pattern = "*",
		command = "set formatoptions-=cro",
	},

	fix_commentstring = {
		event = "BufEnter",
		pattern = "*config,*rc,*conf,sxhkdrc,bspwmrc",
		callback = function()
			vim.bo.commentstring = "#%s"
			vim.bo.filetype = "config"
			-- vim.cmd('set syntax=config')
		end,
	},

	-- BufRead
	restore_cursor_position = {
		event = "BufRead",
		pattern = "*",
		callback = function()
			if vim.bo.filetype == "gitcommit" then
				return
			end
			if fn.line("'\"") > 0 and fn.line("'\"") <= fn.line("$") then
				fn.setpos(".", fn.getpos("'\""))
				vim.api.nvim_feedkeys("zz", "n", true)
			end
		end,
	},

	-- BufWinEnter
	-- enable_Ccc = {
	-- 	event = "BufWinEnter",
	-- 	pattern = "*",
	-- 	callback = function()
	-- 		local status_Ccc, _ = pcall(require, "ccc")
	-- 		if not status_Ccc then
	-- 			return
	-- 		end
	-- 		vim.cmd([[CccHighlighterEnable]])
	-- 	end,
	-- },

	load_default = {
		event = "FileType",
		pattern = {
			"Jaq",
			"qf",
			"help",
			"man",
			"lspinfo",
			"spectre_panel",
			"lir",
			"DressingSelect",
			"tsplayground",
			"qf",
			"txt",
		},

		callback = function()
			vim.wo.relativenumber = false
			vim.wo.number = true
			vim.wo.signcolumn = "no"
			vim.opt_local.spell = false
			vim.opt_local.buflisted = false
			vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>close!<cr>", { noremap = true, silent = true })
		end,
	},

	load_opts = {
		event = "FileType",
		pattern = {
			"gitcommit",
			"markdown",
			"txt",
		},
		callback = function()
			vim.opt_local.wrap = true
			vim.opt_local.spell = true
			vim.bo.spelllang = "en_us"
			vim.g["loaded_spellfile_plugin"] = 0
			vim.api.nvim_buf_set_keymap(0, "n", "j", "gj", { noremap = true })
			vim.api.nvim_buf_set_keymap(0, "n", "k", "gk", { noremap = true })
		end,
	},
}

augroups.terminal = {
	terminal_enter_insert = {
		event = "BufEnter",
		pattern = "*",
		callback = function()
			if vim.bo.buftype == "terminal" then
				vim.cmd([[normal i<CR>]])
			end
		end,
	},

	unlist_terminal = {
		event = "TermOpen",
		pattern = "*",
		command = [[
	   setlocal listchars= nonumber norelativenumber
	   setlocal nobuflisted
	   ]],
	},
}

-- augroups.alpha = {
-- 	disable_alpha_stuff = {
-- 		event = "User",
-- 		pattern = "AlphaReady",
-- 		callback = function()
-- 			local status_alpha, _ = pcall(require, "alpha")
-- 			if not status_alpha then
-- 				return
-- 			end
-- 			vim.go.laststatus = 0
-- 			vim.opt.showtabline = 0
-- 			vim.opt.cmdheight = 0
-- 		end,
-- 	},
--
-- 	enavle_alpha_stuff = {
-- 		event = "BufUnload",
-- 		buffer = 0,
-- 		callback = function()
-- 			local status_alpha, _ = pcall(require, "alpha")
-- 			if not status_alpha then
-- 				return
-- 			end
-- 			vim.go.laststatus = 2
-- 			vim.opt.showtabline = 2
-- 			vim.opt.cmdheight = 1
-- 		end,
-- 	},
-- }

augroups.misc = {
	save_cursor_position = {
		event = { "VimEnter", "CursorMoved" },
		pattern = "*",
		callback = function()
			Cursor_pos = vim.fn.getpos(".")
		end,
	},

	lwindow_quickfix = {
		event = "QuickFixCmdPost",
		pattern = "l*",
		command = [[lwindow | wincmd j]],
	},

	cwindow_quickfix = {
		event = "QuickFixCmdPost",
		pattern = "[^l]*",
		command = [[cwindow | wincmd j]],
	},
}

for group, commands in pairs(augroups) do
	local augroup = vim.api.nvim_create_augroup("AU_" .. group, { clear = true })
	for _, opts in pairs(commands) do
		local event = opts.event
		opts.event = nil
		opts.group = augroup
		vim.api.nvim_create_autocmd(event, opts)
	end
end
