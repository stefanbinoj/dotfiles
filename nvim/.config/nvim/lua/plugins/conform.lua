return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
			json = { "prettierd" },
			jsonc = { "prettierd" },
			yaml = { "prettierd" },
			markdown = { "prettierd" },
			html = { "prettierd" },
			ruby = { "rubocop" },
		},
		-- Per-formatter options (replaces null_ls.builtins.formatting.prettier.with({...})) commit (934ca47d74c6d787aca4bb4e3dab6ac19d61ecc3)
		-- formatters = {
		-- 	prettierd = {
		-- 		prepend_args = { "--print-width", "160" },
		-- 	},
		-- },
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "never", -- never use LSP as a fallback formatter
		},
	},
}
