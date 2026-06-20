return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	ft = "markdown",
	config = function()
		require("render-markdown").setup({
			-- Render in markdown files only
			file_types = { "markdown" },

			-- No latex (no parser installed; avoids unnecessary work)
			latex = {
				enabled = false,
			},

			-- Only GitHub alert callouts (note/tip/important/warning/caution).
			-- Drops the Obsidian callouts the plugin ships by default.
			completions = {
				filter = {
					callout = function(value)
						return value.category == "github"
					end,
				},
			},

			-- Headings: GitHub-style. No Nerd Font icons, no border underline.
			heading = {
				icons = { "", "", "", "", "", "" },
				border = false,
			},

			-- Code blocks: GitHub-style padding, no language label,
			-- inline code gets a column of padding on each side.
			code = {
				language = false,
				inline_pad = 1,
			},
		})

		-- Apply GitHub Primer highlight overrides (defined in
		-- lua/render-markdown-colors.lua). Sourced from the
		-- github_dark_colorblind palette so it stays in sync with the theme.
		require("render-markdown-colors").apply()
	end,
}
