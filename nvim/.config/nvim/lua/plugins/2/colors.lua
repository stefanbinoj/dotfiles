return {
	-- {
	-- 	{
	-- 		"mvllow/modes.nvim",
	-- 		tag = "v0.2.1",
	-- 		config = function()
	-- 			require("modes").setup({
	-- 				colors = {
	-- 					bg = "#22272e",
	-- 					copy = "#c69026", -- attention/yellow
	-- 					delete = "#e5534b", -- danger/red
	-- 					change = "#f69d50", -- variable/orange
	-- 					format = "#dcbdfb", -- entity/purple
	-- 					insert = "#57ab5a", -- success/green
	-- 					replace = "#539bf5", -- accent/blue
	-- 					select = "#b083f0", -- magenta
	-- 					visual = "#b083f0",
	-- 				},
	--
	-- 				line_opacity = 0.12,
	-- 				set_cursor = true,
	-- 				set_cursorline = true,
	-- 				set_number = true,
	-- 				set_signcolumn = true,
	-- 				ignore_filetypes = { "NvimTree", "TelescopePrompt", "minifiles" },
	-- 			})
	-- 		end,
	-- 	},
	-- },
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({})
			vim.api.nvim_command("hi ColorColumn guibg=#545d68")
			vim.cmd("colorscheme github_dark_dimmed")
		end,

		-- "rebelot/kanagawa.nvim",
		-- lazy = false,
		-- priority = 1000,
		-- config = function()
		-- 	require("kanagawa").setup({})
		-- 	vim.cmd("colorscheme kanagawa")
		-- end,

		-- "navarasu/onedark.nvim",
		-- priority = 1000, -- make sure to load this before all the other start plugins
		-- config = function()
		--   require('onedark').setup {
		--     style = 'warmer'
		--   }
		--   require('onedark').load()
		-- end
		--
		--
		-- "joshdick/onedark.vim",
		--  lazy = false,
		--  priority = 1000,
		--  config = function()
		--    vim.cmd([[colorscheme onedark]])
		--  end,
	},
}
