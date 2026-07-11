return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local treesitter = require("nvim-treesitter")

			treesitter.setup()

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "typescript", "typescriptreact", "markdown" },
				callback = function()
					vim.treesitter.start()
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
	{

		"nvim-treesitter/nvim-treesitter-context",
	},
}
