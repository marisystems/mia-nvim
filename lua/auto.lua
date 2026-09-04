-- ========
-- AUTOCMDS
-- ========
local augroup = vim.api.nvim_create_augroup("UserConfig", {clear = true})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  desc = "Higlights text after Yanking",
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Return cursor to last postition
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  desc = "Restore last cursor position",
  callback = function()
    if vim.o.diff then -- So it doesn't happen on diff mode
      return
    end
    
    local last_pos = vim.api.nvim_buf_get_mark(0, '"') -- {line, col}
    local last_line = vim.api.nvim_buf_line_count(0)
    local row = last_pos[1]

    if row < 1 or row > last_line then
      return
    end

    pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
  end,
})

-- Wrap, Linebreak and spellcheck for .md and text files
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = {"markdown", "text", "gitcommit"},
  desc = "Add wrap, linebreak and spellcheck for markdown and text files",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
  end,
})
