local keymap = vim.keymap.set
local generic_opts_any = { noremap = true, silent = true }

-- Utility function to safely set keymaps based on plugin availability
local function safe_keymap(plugin_name, keymaps)
  local status, plugin = pcall(require, plugin_name)
  local keymap_list = status and keymaps.setup or keymaps.fallback
  if keymap_list then
    for _, keymap_entry in ipairs(keymap_list) do
      -- Ensure function keymaps are correctly handled
      if type(keymap_entry[4]) == "function" then keymap_entry[4] = { callback = keymap_entry[4], silent = true } end
      keymap(unpack(keymap_entry))
    end
  end
end

-- Define keymaps for each plugin with setup and fallback tables
local keymaps = {
  file_exp = {
    setup = { { "n", "<leader>e", "<CMD>NvimTreeToggle<CR>", generic_opts_any } },
    fallback = { { "n", "<leader>e", "<CMD>Ex<CR>", generic_opts_any } },
  },
  buff_nav = {
    setup = {
      { "n", "<S-h>", "<CMD>BufferLineCyclePrev<CR>", generic_opts_any },
      { "n", "<S-l>", "<CMD>BufferLineCycleNext<CR>", generic_opts_any },
    },
    fallback = {
      { "n", "<S-h>", "<CMD>bprevious<CR>", generic_opts_any },
      { "n", "<S-l>", "<CMD>bnext<CR>", generic_opts_any },
    },
  },
  luasnip = {
    setup = {
      {
        { "i", "s" },
        "<C-e>",
        function()
          local ls = require("luasnip")
          if ls.expandable() then ls.expand() end
        end,
      },
      {
        { "i", "s" },
        "<C-n>",
        function()
          local ls = require("luasnip")
          if ls.jumpable(1) then ls.jump(1) end
        end,
      },
      {
        { "i", "s" },
        "<C-p>",
        function()
          local ls = require("luasnip")
          if ls.jumpable(-1) then ls.jump(-1) end
        end,
      },
      {
        "i",
        "<C-k>",
        function()
          local ls = require("luasnip")
          if ls.choice_active() then ls.change_choice(1) end
        end,
        generic_opts_any,
      },
      {
        "i",
        "<C-j>",
        function()
          local ls = require("luasnip")
          if ls.choice_active() then ls.change_choice(-1) end
        end,
        generic_opts_any,
      },
    },
    fallback = {},
  },
  fterm = {
    setup = {
      { "n", "<A-t>", '<CMD>lua require("FTerm").toggle()<CR>' },
      { "t", "<A-t>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>' },
      { "t", "<ESC>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>' },
    },
    fallback = {},
  },
}

-- Apply keymaps
safe_keymap("nvim-tree", keymaps.file_exp)
safe_keymap("bufferline", keymaps.buff_nav)
safe_keymap("luasnip", keymaps.luasnip)
safe_keymap("FTerm", keymaps.fterm)
