# Neovim Config

<img width="1907" height="1023" alt="Neovim Config Screenshot" src="https://placehold.co/1907x1023/1e1e2e/ffffff?text=Neovim+Config+Screenshot&font=roboto" />

Modern Neovim setup with essential plugins.

## Features

- GitHub Copilot integration
- LSP with Mason & auto-completion
- Telescope fuzzy finder with extensions
- Neo-tree file explorer
- Git workflow (Fugitive + Gitsigns)
- Treesitter syntax highlighting + context
- Auto-formatting (conform.nvim) & diagnostics
- Session persistence
- Markdown rendering
- Folding (nvim-ufo)
- Auto-closing brackets/tags
- TODO/FIXME highlighting

## Plugins

**UI & Appearance**
- [github-nvim-theme](https://github.com/projekt0n/github-nvim-theme) - Dark colorscheme
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - Statusline
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) - File icons
- [dressing.nvim](https://github.com/stevearc/dressing.nvim) - Better input UI
- [vim-illuminate](https://github.com/RRethy/vim-illuminate) - Highlight word under cursor
- [vim-search-pulse](https://github.com/inside/vim-search-pulse) - Pulse on search
- [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) - Markdown rendering

**Navigation & Files**
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
  - [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) - FZF sorter
  - [telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim) - Picker for UI select
  - [telescope-undo.nvim](https://github.com/debugloop/telescope-undo.nvim) - Undo history picker
  - [telescope-git-file-history.nvim](https://github.com/lewis6991/telescope-git-file-history.nvim) - Git file history
- [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) - File explorer
- [persistence.nvim](https://github.com/folke/persistence.nvim) - Session management
- [undotree](https://github.com/mbbill/undotree) - Undo history visualizer

**Editing**
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax highlighting
- [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) - Show context above
- [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) - Fold with treesitter
- [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) - Auto close/rename HTML tags
- [autoclose.nvim](https://github.com/m4xshen/autoclose.nvim) - Auto close brackets/quotes
- [Comment.nvim](https://github.com/numToStr/Comment.nvim) - Toggle comments
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) - Highlight TODO/FIXME/etc.

**LSP & Completion**
- [mason.nvim](https://github.com/williamboman/mason.nvim) - LSP installer
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) - Bridge mason & lspconfig
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP configs
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Auto-completion engine
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip) - Snippet engine
- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) - LSP source for cmp
- [cmp-buffer](https://github.com/hrsh7th/cmp-buffer) - Buffer words source
- [cmp-path](https://github.com/hrsh7th/cmp-path) - Path source
- [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) - Snippet source
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) - Snippet collection
- [copilot.vim](https://github.com/github/copilot.vim) - AI assistance

**Formatting**
- [conform.nvim](https://github.com/stevearc/conform.nvim) - Formatter runner

**Git & Utils**
- [vim-fugitive](https://github.com/tpope/vim-fugitive) - Git integration
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git signs
- [openingh.nvim](https://github.com/almo7aya/openingh.nvim) - Open files/repos on GitHub
- [vim-wakatime](https://github.com/wakatime/vim-wakatime) - Time tracking
