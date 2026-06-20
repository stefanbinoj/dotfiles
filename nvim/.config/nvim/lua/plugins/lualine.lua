return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = {
					normal = {
						a = { fg = "#22272e", bg = "#539bf5", gui = "bold" },
						b = { fg = "#adbac7", bg = "#2d333b" },
						c = { fg = "#adbac7", bg = "#22272e" },
					},
					insert = {
						a = { fg = "#22272e", bg = "#57ab5a", gui = "bold" },
						b = { fg = "#adbac7", bg = "#2d333b" },
						c = { fg = "#adbac7", bg = "#22272e" },
					},
					visual = {
						a = { fg = "#22272e", bg = "#b083f0", gui = "bold" },
						b = { fg = "#adbac7", bg = "#2d333b" },
						c = { fg = "#adbac7", bg = "#22272e" },
					},
					replace = {
						a = { fg = "#22272e", bg = "#f47067", gui = "bold" },
						b = { fg = "#adbac7", bg = "#2d333b" },
						c = { fg = "#adbac7", bg = "#22272e" },
					},
					command = {
						a = { fg = "#22272e", bg = "#daaa3f", gui = "bold" },
						b = { fg = "#adbac7", bg = "#2d333b" },
						c = { fg = "#adbac7", bg = "#22272e" },
					},
					terminal = {
						a = { fg = "#22272e", bg = "#39c5cf", gui = "bold" },
						b = { fg = "#adbac7", bg = "#2d333b" },
						c = { fg = "#adbac7", bg = "#22272e" },
					},
					inactive = {
						a = { fg = "#768390", bg = "#2d333b" },
						b = { fg = "#768390", bg = "#2d333b" },
						c = { fg = "#768390", bg = "#22272e" },
					},
				},
			},
			sections = {
				lualine_x = {},
				lualine_c = {
					{
						"filename",
						file_status = true, -- Displays file status (readonly status, modified status)
						newfile_status = false, -- Display new file status (new file means no write after created)
						path = 1, -- 0: Just the filename
						-- 1: Relative path
						-- 2: Absolute path
						-- 3: Absolute path, with tilde as the home directory
						-- 4: Filename and parent dir, with tilde as the home directory

						shorting_target = 40, -- Shortens path to leave 40 spaces in the window
						-- for other components. (terrible name, any suggestions?)
						symbols = {
							modified = "●", -- Text to show when the file is modified.
							readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
							unnamed = "[No Name]", -- Text to show for unnamed buffers.
							newfile = "[New]", -- Text to show for newly created file before first write
						},
					},
				},
			},
		})
	end,
}
