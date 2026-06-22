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
			auto_install = true, -- Auto-install any LSP you don't have when mason sees it
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
					complete_function_calls = true,
					vtsls = {
						autoUseWorkspaceTsdk = true, -- Use workspace TypeScript SDK if present
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
					javascript = {
						updateImportsOnFileMove = { enabled = "always" },
						preferences = {
							importModuleSpecifier = "shortest",
							importModuleSpecifierEnding = "minimal",
							includePackageJsonAutoImports = "on",
						},
					},
				},
			})

			vim.lsp.config("lua_ls", { capabilities = capabilities })

			-- === Auto-enable all mason-installed servers (Dax pattern) ===
			-- Iterates whatever mason has installed and enables each one.
			local mason_lspconfig = require("mason-lspconfig")
			for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
				pcall(vim.lsp.enable, server)
			end

			-- === LSP keybinds on LspAttach (Dax pattern: buffer-local, modern way) ===
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
				callback = function(event)
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					local bufopts = { buffer = event.buf }

					-- Disable semantic tokens (Dax pattern)
					-- Why: when both LSP and treesitter highlight the same thing, you get
					-- weird overlap / flicker. Treesitter handles highlighting,
					-- LSP handles go-to / completion / rename. Cleaner look.
					if client and client.server_capabilities then
						client.server_capabilities.semanticTokensProvider = nil
					end

					-- Helper: merge buffer-local opts with a desc for which-key display
					local function key(desc)
						return vim.tbl_extend("force", bufopts, { desc = desc })
					end

					-- Existing keybinds (kept):
					vim.keymap.set("n", "K", vim.lsp.buf.hover, key("Hover docs")) -- Docs for symbol under cursor
					vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, key("Go to definition")) -- Where symbol is defined
					vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, key("Go to references")) -- All references to symbol

					-- New keybinds from Dax's pattern:
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, key("Go to declaration")) -- Symbol's declaration (vs definition)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, key("Go to implementation")) -- For interfaces/abstracts: jump to concrete impl
					vim.keymap.set("n", "go", vim.lsp.buf.type_definition, key("Go to type definition")) -- For vars: jump to type/typedef
					vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, key("Signature help")) -- Function signature in normal mode

					-- Existing keybinds (kept):
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, key("Code actions")) -- Available code actions
					vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, key("Format buffer")) -- Format current buffer

					-- New keybinds from Dax's pattern:
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, key("Rename symbol")) -- Rename symbol across project

					-- === Insert mode ===
					vim.keymap.set("i", "<C-j>", vim.lsp.buf.signature_help, key("Signature help")) -- Trigger signature help while typing
				end,
			})

			-- Diagnostic config — same style as the deleted lua/plugins/none-ls.lua (934ca47).
			vim.diagnostic.config({
				virtual_text = true, -- inline errors
				signs = true, -- gutter icons
				underline = true, -- underline text
				update_in_insert = false, -- don't spam while typing
				severity_sort = true, -- sort by severity
			})

			-- floating diagnostic on hover
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
