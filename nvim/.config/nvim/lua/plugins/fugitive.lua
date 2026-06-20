local function github_dark_diff_highlights()
	local overrides = {
		DiffAdd = { bg = "#0c2818", fg = "NONE" },
		DiffDelete = { bg = "#3a1f1f", fg = "NONE" },
		DiffChange = { bg = "#3a2e0a", fg = "NONE" },
		DiffText = { bg = "#4d3819", fg = "#adbac7" },
    DiffAdded = { fg = "#6bc46d", bold = true },
    DiffRemoved = { fg = "#ff938a", strikethrough = false },
    DiffChanged = { fg = "#daaa3f", underline = false },
    DiffviewWinSeparator = { fg = "#444c56" },
    DiffviewDiffDelete = { fg = "#444c56" },
    DiffviewFilePanelSelected = { fg = "#dcbdfb" },
    DiffviewStatusAdded = { fg = "#6bc46d", bold = true },
    DiffviewStatusUntracked = { fg = "#6cb6ff", bold = true },
    DiffviewStatusModified = { fg = "#daaa3f", bold = true },
    DiffviewStatusRenamed = { fg = "#6bc46d", bold = true },
    DiffviewStatusDeleted = { fg = "#ff938a", bold = true },
    DiffviewStatusIgnored = { fg = "#768390", bold = true },
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
