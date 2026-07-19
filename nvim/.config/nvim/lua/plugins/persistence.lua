-- If you ever want manual control, flip `no_mappings = false` to get
-- the default <leader>qs / <leader>ql / <leader>qd / <leader>qj.

return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup({
        no_mappings = true, -- zero keybinds; you don't have to think about it
    --    autosave = true, -- uncomment to also save on BufWritePost + FocusLost (crash safety)
      })
    end,
  },
}
