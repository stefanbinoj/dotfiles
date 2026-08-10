return {
  {
    "folke/persistence.nvim",
    lazy = false,
    config = function()
      local persistence = require("persistence")

      persistence.setup({
        need = 0,
        branch = false,
      })

      local argc = vim.fn.argc()
      local directory_argument = argc == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1
      local argument_path = directory_argument and vim.fn.fnamemodify(vim.fn.argv(0), ":p") or ""
      local cwd_path = vim.fn.getcwd() .. "/"
      local restore_project = argc == 0 or argument_path == cwd_path

      if directory_argument then
        for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_valid(buffer)
            and vim.api.nvim_buf_get_name(buffer) == vim.fn.getcwd() then
            pcall(vim.api.nvim_buf_delete, buffer, { force = true })
          end
        end
      end

      if restore_project then
        vim.schedule(function()
          persistence.load()
        end)
      end
    end,
  },
}
