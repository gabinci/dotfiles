-- current file path: /home/gabinci/dotfiles/.config/nvim/snippets/markdown.lua
-- last change: Tue, 22 Nov 2022 - 13:58:56
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
