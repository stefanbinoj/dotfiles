return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		-- Default keywords: TODO, FIXME, HACK, XXX, NOTE, BUG, WARN, PERF, IDEA
	},
	keys = {
		{
			"]t",
			function()
				require("todo-comments").jump_next() -- TODO: Learn
			end,
			desc = "Next TODO comment",
		},
		{
			"[t",
			function()
				require("todo-comments").jump_prev() -- TODO: Learn
			end,
			desc = "Previous TODO comment",
		},
	},
}
