return {
  "sindrets/diffview.nvim",
  cmd = "DiffviewOpen",
  keys = {
    {
      "<leader>gg",
      function()
        local lib = require("diffview.lib")
        local view = lib.get_current_view()
        if view then
          vim.cmd("DiffviewClose")
        else
          vim.cmd("DiffviewOpen")
        end
      end,
      desc = "Toggle Diffview",
    },
  },
  config = function()
    vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#462F2F" })

    require("diffview").setup({
      file_panel = {
        listing_style = "list",
      },
    })
  end,
}
