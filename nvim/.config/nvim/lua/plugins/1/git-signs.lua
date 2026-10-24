return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()

			-- Navigate to next/previous git hunks
			vim.keymap.set('n', ']c', function()
				if vim.wo.diff then return ']c' end
				vim.schedule(function() require('gitsigns').next_hunk() end)
				return '<Ignore>'
			end, {expr=true, desc = "Next git hunk"})

			vim.keymap.set('n', '[c', function()
				if vim.wo.diff then return '[c' end
				vim.schedule(function() require('gitsigns').prev_hunk() end)
				return '<Ignore>'
			end, {expr=true, desc = "Previous git hunk"})

			-- Git hunk actions
			vim.keymap.set('n', '<leader>hs', ':Gitsigns stage_hunk<CR>', { desc = "Stage hunk" })
			vim.keymap.set('n', '<leader>hr', ':Gitsigns reset_hunk<CR>', { desc = "Reset hunk" })
			vim.keymap.set('n', '<leader>hS', ':Gitsigns stage_buffer<CR>', { desc = "Stage buffer" })
			vim.keymap.set('n', '<leader>hR', ':Gitsigns reset_buffer<CR>', { desc = "Reset buffer" })
			vim.keymap.set('n', '<leader>tb', ':Gitsigns toggle_current_line_blame<CR>', { desc = "Toggle line blame" })
      vim.keymap.set('n', '<leader>hp', ':Gitsigns preview_hunk<CR>', { desc = "Preview hunk" }) -- TODO: learn
			vim.keymap.set('n', '<leader>td', ':Gitsigns toggle_deleted<CR>', { desc = "Toggle deleted" })

		end,
	},
}
