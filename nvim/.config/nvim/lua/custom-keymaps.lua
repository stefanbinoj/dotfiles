-- Helper func
local function copy_file_path(absolute)
  local path = vim.fn.expand(absolute and "%:p" or "%:.")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end


local function copy_path_with_lines(absolute)
  local filepath = vim.fn.expand(absolute and "%:p" or "%:.")

  local start_line, end_line

  if vim.fn.mode():match("[vV\22]") then
    start_line = vim.fn.line("v")
    end_line = vim.fn.line(".")
    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end
  else
    start_line = vim.fn.line(".")
    end_line = start_line
  end

  local text
  if start_line == end_line then
    text = string.format("%s:%d", filepath, start_line)
  else
    text = string.format("%s:%d-%d", filepath, start_line, end_line)
  end

  vim.fn.setreg("+", text)
  vim.notify("Copied: " .. text)
end


local function copy_code_snippet(absolute)
  local filepath = vim.fn.expand(absolute and "%:p" or "%:.")
  local ft = vim.bo.filetype

  local start_line, end_line

  if vim.fn.mode():match("[vV\22]") then
    start_line = vim.fn.line("v")
    end_line = vim.fn.line(".")
    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end
  else
    start_line = vim.fn.line(".")
    end_line = start_line
  end

  local lines = vim.api.nvim_buf_get_lines(
    0,
    start_line - 1,
    end_line,
    false
  )

  local payload

  if start_line == end_line then
    payload = string.format(
      "File: %s\nLine: %d\n\n```%s\n%s\n```",
      filepath,
      start_line,
      ft,
      table.concat(lines, "\n")
    )
  else
    payload = string.format(
      "File: %s\nLines: %d-%d\n\n```%s\n%s\n```",
      filepath,
      start_line,
      end_line,
      ft,
      table.concat(lines, "\n")
    )
  end

  vim.fn.setreg("+", payload)
  vim.notify("Copied code snippet")
end

-- Keybindings
vim.keymap.set({ "n", "v" }, "<leader>cs", function()
  copy_code_snippet(false)
end, { desc = "Copy relative code snippet" })

vim.keymap.set({ "n", "v" }, "<leader>cS", function()
  copy_code_snippet(true)
end, { desc = "Copy absolute code snippet" })

vim.keymap.set("n", "<leader>fp", function()
  copy_file_path(false)
end, { desc = "Copy relative file path" })

vim.keymap.set("n", "<leader>fP", function()
  copy_file_path(true)
end, { desc = "Copy absolute file path" })

vim.keymap.set({ "n", "v" }, "<leader>cp", function()
  copy_path_with_lines(false)
end, { desc = "Copy relative path with line(s)" })

vim.keymap.set({ "n", "v" }, "<leader>cP", function()
  copy_path_with_lines(true)
end, { desc = "Copy absolute path with line(s)" })
