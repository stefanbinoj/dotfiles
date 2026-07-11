return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"isak102/telescope-git-file-history.nvim",
			"debugloop/telescope-undo.nvim",
		},
		config = function()
			require("telescope").setup({
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
						"-g",
						"!node_modules/*",
						"-g",
						"!.git/*",
					},
				},
				pickers = {
					find_files = {
						find_command = { "rg", "--files", "--ignore", "--hidden", "-g", "!node_modules/*", "-g", "!.git/*" },
					},
				},
			})

			-- Load extensions
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("git_file_history")
			require("telescope").load_extension("undo")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Find files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
			vim.keymap.set("n", "<leader>vh", builtin.help_tags, { desc = "Help tags" })
			vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" }) -- TODO: learn
			vim.keymap.set("n", "<leader>gh", "<cmd>Telescope git_file_history<cr>", { desc = "Git file history (current file)" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
