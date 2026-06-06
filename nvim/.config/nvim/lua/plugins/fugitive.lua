local function github_dark_diff_highlights()
	local overrides = {
		DiffAdd = { bg = "#1d4225", fg = "NONE" },
		DiffDelete = { bg = "#462F2F", fg = "NONE" },
		DiffChange = { bg = "#4A3F1E", fg = "NONE" },
		DiffText = { bg = "#9E8F3A", fg = "#1E1E1E" },
    DiffAdded = { fg = "#9ece6a", bold = true },
    DiffRemoved = { fg = "#f7768e", strikethrough = false },
    DiffChanged = { fg = "#E0AF68", underline = false },
    DiffviewWinSeparator = { fg = "#5c6370" },
    DiffviewDiffDelete = { fg = "#5c6370" },
    DiffviewFilePanelSelected = { fg = "#c678dd" },
    DiffviewStatusAdded = { fg = "#9ece6a", bold = true },
    DiffviewStatusUntracked = { fg = "#7aa2f7", bold = true },
    DiffviewStatusModified = { fg = "#E0AF68", bold = true },
    DiffviewStatusRenamed = { fg = "#9ece6a", bold = true },
    DiffviewStatusDeleted = { fg = "#f7768e", bold = true },
    DiffviewStatusIgnored = { fg = "#5c6370", bold = true },
  }

	for group, opts in pairs(overrides) do
		vim.api.nvim_set_hl(0, group, opts)
	end
end

return {
	"tpope/vim-fugitive",
	config = function()
		local diff_group = vim.api.nvim_create_augroup("GitHubDarkDiff", { clear = true })
		vim.api.nvim_create_autocmd("ColorScheme", {
			group = diff_group,
			pattern = "*",
			callback = github_dark_diff_highlights,
		})
		github_dark_diff_highlights()

		-- Global shortcut: Git status
		vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status" })
	end,
}
