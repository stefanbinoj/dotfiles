return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "vtsls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.lsp.config("vtsls", {
				capabilities = capabilities,
				settings = {
					vtsls = {
						autoUseWorkspaceTsdk = true,
					},
					typescript = {
						updateImportsOnFileMove = { enabled = "always" },
						suggest = { completeFunctionCalls = true },
						preferences = {
							importModuleSpecifier = "shortest",
							importModuleSpecifierEnding = "minimal",
							includePackageJsonAutoImports = "on",
						},
						inlayHints = {
							parameterNames = { enabled = "literals" },
							parameterTypes = { enabled = true },
							variableTypes = { enabled = false },
							propertyDeclarationTypes = { enabled = true },
							functionLikeReturnTypes = { enabled = true },
							enumMemberValues = { enabled = true },
						},
					},
				},
			})

			vim.lsp.config("lua_ls", { capabilities = capabilities })

			local mason_lspconfig = require("mason-lspconfig")
			for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
				pcall(vim.lsp.enable, server)
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
				callback = function(event)
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					local bufopts = { buffer = event.buf }

					if client and client.server_capabilities then
						client.server_capabilities.semanticTokensProvider = nil
					end

					local function key(desc)
						return vim.tbl_extend("force", bufopts, { desc = desc })
					end

					vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, key("Go to definition"))
					vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, key("Go to references"))
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, key("Go to declaration")) -- TODO: learn
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, key("Go to implementation"))
					vim.keymap.set("n", "go", vim.lsp.buf.type_definition, key("Go to type definition"))
					vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, key("Signature help"))
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, key("Code actions"))
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, key("Rename symbol"))
					vim.keymap.set("i", "<C-j>", vim.lsp.buf.signature_help, key("Signature help"))
				end,
			})

			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open diagnostic modal" })
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
			end, { desc = "Previous error diagnostic" })
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
			end, { desc = "Next error diagnostic" })
		end,
	},
}
