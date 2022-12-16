local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
	return
end
-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- █▀▀ █▀█ █▀█ █▀▀
	-- █▄▄ █▄█ █▀▄ ██▄

	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim")
	use("nvim-tree/nvim-web-devicons")

	-- █▀ █▀▀ █▀█ █░█ █▀▀ █▀█ █▀
	-- ▄█ ██▄ █▀▄ ▀▄▀ ██▄ █▀▄ ▄█

	-- autocompletion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("f3fora/cmp-spell")
	use("dcampos/cmp-emmet-vim")

	-- snippets
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")
	use("mattn/emmet-vim")

	-- manage & install lsp servers, linters & formatters
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")

	-- configuring lsp servers
	use("neovim/nvim-lspconfig")
	use("hrsh7th/cmp-nvim-lsp")
	use("glepnir/lspsaga.nvim")
	use("jose-elias-alvarez/typescript.nvim")
	use("onsails/lspkind.nvim")
	use("folke/trouble.nvim")

	-- formatting & linting
	use("Jose-elias-alvarez/null-ls.nvim")
	use("jayp0521/mason-null-ls.nvim")

	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- treesitter

	-- █ █ ▀█▀ █ █   ▄▀▀
	-- ▀▄█  █  █ █▄▄ ▄██
	-- utils

	use("lewis6991/impatient.nvim") -- impatient nvim
	use("nvim-tree/nvim-tree.lua") -- nvim tree
	use("nvim-telescope/telescope.nvim") -- telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- telescope fzf
	use("numToStr/Comment.nvim") -- comment
	use("windwp/nvim-ts-autotag") -- auto tags
	use("aurum77/live-server.nvim") -- live server
	use("windwp/nvim-autopairs") -- autopairs

	use("romgrk/fzy-lua-native")

	use({
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({})
		end,
	}) -- nvim surround

	-- md preview
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	-- █ █ █ ▄▀▀ █ █ ▄▀▄ █
	-- ▀▄▀ █ ▄██ ▀▄█ █▀█ █▄▄
	-- visual

	use("lukas-reineke/indent-blankline.nvim") -- indent line
	use("lewis6991/gitsigns.nvim") -- git signs
	use("nvim-lualine/lualine.nvim") -- statusline
	use("akinsho/bufferline.nvim") -- bufferline
	use("goolord/alpha-nvim") -- dashboard
	use("stevearc/dressing.nvim") -- dressing
	use("christianchiarulli/lir.nvim") -- lir

	use("gelguy/wilder.nvim") -- wilder
	use("nixprime/cpsm")
	use("MunifTanjim/nui.nvim") -- popup
	use("rcarriga/nvim-notify") -- notifications
	use("folke/noice.nvim") -- ui

	use({
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				filetypes_denylist = {
					"alpha",
					"NvimTree",
					"packer",
					"telescope",
				},
			})
		end,
	})

	use({
		"uga-rosa/ccc.nvim",
		config = function()
			require("ccc").setup({
				highlighter = {
					auto_enable = true,
				},
			})
		end,
	})

	-- THEMES
	-- use("folke/tokyonight.nvim")
	-- use("ray-x/aurora")
	-- use("navarasu/onedark.nvim")
	use("catppuccin/nvim")

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
