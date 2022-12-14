---@diagnostic disable
-- current file path: /home/gabinci/dotfiles/.config/nvim/snippets/markdown.lua
-- last change: Wed, 14 Dec 2022 - 12:49:27
-- Author: gabinci

return {
	s(
		{ trig = "cbl", desc = "Code block" },
		fmta(
			[[
    ```<>
    <>
    ```
    ]],
			{ i(1, "LANGUAGE"), i(0) }
		)
	),
}
