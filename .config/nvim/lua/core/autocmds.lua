-- Filename: autocmds.lua
-- Last Change: 
-- vim:set ft=lua softtabstop=2 shiftwidth=2 tabstop=2 expandtab nolist:

--  █████╗ ██╗   ██╗████████╗ ██████╗  ██████╗███╗   ███╗██████╗ ███████╗
-- ██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗██╔════╝████╗ ████║██╔══██╗██╔════╝
-- ███████║██║   ██║   ██║   ██║   ██║██║     ██╔████╔██║██║  ██║███████╗
-- ██╔══██║██║   ██║   ██║   ██║   ██║██║     ██║╚██╔╝██║██║  ██║╚════██║
-- ██║  ██║╚██████╔╝   ██║   ╚██████╔╝╚██████╗██║ ╚═╝ ██║██████╔╝███████║
-- ╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝  ╚═════╝╚═╝     ╚═╝╚═════╝ ╚══════╝

local fn = vim.fn
local augroups = {}
local autocmd = vim.api.nvim_create_autocmd

augroups.insert = {

	-- clear_search_highlighting = {
	-- 	event = "InsertEnter",
	-- 	pattern = "*",
	-- 	callback = function()
	-- 		vim.opt_local.hlsearch = false
	-- 		vim.fn.clearmatches()
	-- 	end,
	-- },

	-- match_extra_spaces = {
	-- 	event = "InsertLeave",
	-- 	pattern = "*",
	-- 	command = [[
	--    highlight RedundantSpaces ctermbg=red guibg=red
	--    match RedundantSpaces /\s\+$/
	--    ]],
	-- },

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

augroups.misc = {

	-- Disable the statusline, tabline and cmdline while the alpha dashboard is open

	-- autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
	-- alpha_hidetabline = {
	-- 	event = "User",
	-- 	pattern = "AlphaReady",
	-- 	callback = function()
	-- 		vim.opt_local.showtabline = 2
	-- 	end,
	-- },

	-- autocmd BufEnter * :

	unlist_terminal = {
		event = "TermOpen",
		pattern = "*",
		command = [[
    tnoremap <buffer> <Esc> <c-\><c-n>
    tnoremap <buffer> <leader>x <c-\><c-n>:bd!<cr>
    tnoremap <expr> <A-r> '<c-\><c-n>"'.nr2char(getchar()).'pi'
    startinsert
    nnoremap <buffer> <C-c> i<C-c>
    setlocal listchars= nonumber norelativenumber
    setlocal nobuflisted
    ]],
	},

	reload_sxhkd = {
		event = "BufWritePost",
		pattern = "sxhkdrc",
		command = [[!pkill -USR1 -x sxhkd]],
	},

	-- close_buffers_with_q = {
	-- 	event = "FileType",
	-- 	pattern = "qf,help,man, lspinfo",
	-- 	command = 'vim.api.nvim_set_keymap("n", "q", ":close<CR>", { silent = true, noremap = true })',
	-- },

	-- make_scripts_executable = {
	-- 	event = "BufWritePost",
	-- 	pattern = "*.sh,*.py,*.zsh",
	-- 	callback = function()
	-- 		local file = vim.fn.expand("%p")
	-- 		local status = require("core.utils").is_executable()
	-- 		if status ~= true then
	-- 			vim.fn.setfperm(file, "rwxr-x---")
	-- 		end
	-- 	end,
	-- },

	update_xresources = {
		event = "BufWritePost",
		pattern = "~/.Xresources",
		command = [[!xrdb -merge ~/.Xresources]],
	},

	updated_xdefaults = {
		event = "BufWritePost",
		pattern = "~/.Xdefaults",
		command = [[!xrdb -merge ~/.Xdefaults]],
	},

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

	enable_Ccc = {
		event = "BufWinEnter",
		pattern = "*",
		command = "CccHighlighterEnable",
	},

	-- auto_chdir = {
	--   event = "BufEnter",
	--   pattern = "*",
	--   command = [[silent! lcd %:p:h]]
	-- },

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

-- augroups.toggle_cursorline = {
--
--   enable_cursorline = {
--     event = { "VimEnter","WinEnter","BufWinEnter" },
--     pattern = "*",
--     callback = function()
--       vim.opt.cursorline = true
--     end,
--   },
--
--   disable_cursorline = {
--     event = "WinLeave",
--     pattern = "*",
--     command = [[set nocursorline]]
--   },
--
-- }

augroups.yankpost = {
	highlight_yank = {
		event = "TextYankPost",
		pattern = "*",
		callback = function()
			-- vim.highlight.on_yank({ higroup = "Visual", timeout = 300, on_visual = true })
			vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300, on_visual = true })
		end,
	},
	save_cursor_position = {
		event = { "VimEnter", "CursorMoved" },
		pattern = "*",
		callback = function()
			Cursor_pos = vim.fn.getpos(".")
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
	-- buf wirite pre
	mkdir_before_saving = {
		event = { "BufWritePre", "FileWritePre" },
		pattern = "*",
		callback = function(ctx)
			vim.fn.mkdir(vim.fn.fnamemodify(ctx.file, ":p:h"), "p")
		end,
	},

	change_header = {
		event = "BufWritePre",
		pattern = "*",
		callback = function()
			require("core.utils").changeHeader()
		end,
	},

	-- buf wire post
	--Packer_Update = {
	--  event = "BufWritePost",
	--  pattern = "packer_init.lua",
	--  callback = function()
	--    vim.cmd [[source <afile> | PackerSync]]
	--  end,
	--},

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
}

autocmd("User", {
	pattern = "AlphaReady",
	callback = function()
		vim.go.laststatus = 0
		vim.opt.showtabline = 0
		vim.opt.cmdheight = 0
	end,
})

autocmd("BufUnload", {
	buffer = 0,
	callback = function()
		vim.go.laststatus = 2
		vim.opt.showtabline = 2
		vim.opt.cmdheight = 1
	end,
})
--
for group, commands in pairs(augroups) do
	local augroup = vim.api.nvim_create_augroup("AU_" .. group, { clear = true })

	for _, opts in pairs(commands) do
		local event = opts.event
		opts.event = nil
		opts.group = augroup
		vim.api.nvim_create_autocmd(event, opts)
	end
end
