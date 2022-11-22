-- current file path: /home/gabinci/dotfiles/.config/nvim/snippets/all.lua
-- last change: Tue, 22 Nov 2022 13:53:22
-- Author: gabinci

return {
	s(
		{
			trig = "__skel",
			desc = "boil",
		},
		fmta(
			[[
    <>
    <>
    <>
    ]],
			{
				f(function()
					local name = vim.api.nvim_buf_get_name(0)
					return "-- current file path: " .. name
				end),
				f(function()
					return "-- last change: " .. os.date("%a, %d %b %Y - %H:%M:%S")
				end),
				f(function()
					return "-- Author: " .. os.getenv("USER")
				end),
			}
		)
	),
}
