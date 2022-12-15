local status, telescope = pcall(require, "telescope")
if not status then
	require("core.log").log_error("telescope")
	return
end

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, {})

local actions = require("telescope.actions")
telescope.setup({
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },
		--		entry_prefix = "  ",
		--		initial_mode = "insert",
		--		selection_strategy = "reset",
		--		sorting_strategy = nil,
		--		vimgrep_arguments = {
		--			"rg",
		--			"--color=never",
		--			"--no-heading",
		--			"--with-filename",
		--			"--line-number",
		--			"--column",
		--			"--smart-case",
		--			"--hidden",
		--			"--glob=!.git/",
		--			file_ignore_patterns = {},
		--			winblend = 0,
		--			border = {},
		--			borderchars = nil,
		--			color_devicons = true,
		--			set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		--	},

		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-l>"] = actions.select_default,
				["<CR>"] = actions.select_default,
				["<esc>"] = actions.close,
				["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
			},
		},
	},

	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
	},

	pickers = {
		find_files = {
			hidden = true,
			find_command = { "fd", "--type", "f" },
		},
		live_grep = {
			--@usage don't include the filename in the search results
			only_sort_text = true,
		},
		grep_string = {
			only_sort_text = true,
		},
		buffers = {
			initial_mode = "normal",
			mappings = {
				i = {
					["<C-d>"] = actions.delete_buffer,
				},
				n = {
					["dd"] = actions.delete_buffer,
				},
			},
		},
		planets = {
			show_pluto = true,
			show_moon = true,
		},
		git_files = {
			hidden = true,
			show_untracked = true,
		},
	},
})

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:

local putils = require("telescope.previewers.utils")
local pfiletype = require("plenary.filetype")
local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local _bad = { ".*%.csv", ".*%.svg", ".*%tmTheme" } -- Put all filetypes that slow you down in this array
local bad_files = function(filepath)
	for _, v in ipairs(_bad) do
		if filepath:match(v) then
			return false
		end
	end

	return true
end

local new_maker = function(filepath, bufnr, opts)
	opts = opts or {}
	if opts.use_ft_detect == nil then
		opts.use_ft_detect = true
	end
	opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)
	previewers.buffer_previewer_maker(filepath, bufnr, opts)

	filepath = vim.fn.expand(filepath)
	Job:new({
		command = "file",
		args = { "--mime-type", "-b", filepath },
		on_exit = function(j)
			local mime_type = vim.split(j:result()[1], "/")[1]
			if mime_type == "text" then
				previewers.buffer_previewer_maker(filepath, bufnr, opts)
			else
				-- maybe we want to write something to the buffer here
				vim.schedule(function()
					vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
				end)
			end
		end,
	}):sync()
	opts = opts or {}
	if opts.use_ft_detect == nil then
		local ft = pfiletype.detect(filepath)
		-- Here for example you can say: if ft == "xyz" then this_regex_highlighing else nothing end
		opts.use_ft_detect = false
		putils.regex_highlighter(bufnr, ft)
	end
	previewers.buffer_previewer_maker(filepath, bufnr, opts)
end

telescope.setup({
	defaults = {
		buffer_previewer_maker = new_maker,
	},
})

telescope.load_extension("fzf")
