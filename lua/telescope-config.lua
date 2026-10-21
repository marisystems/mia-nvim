-- Telescope
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local map = vim.keymap.set

require("telescope").setup({
  defaults = {
    -- Make telescope start on normal mode
    initial_mode = 'normal',
    mappings = {
      i = {
        ["<c-d>"] = actions.delete_buffer,

        -- Make Telescope file picker go up a parent folder with Control+Up
        ["<C-up>"] = function(prompt_bufnr)
            local current_picker =
                require("telescope.actions.state").get_current_picker(prompt_bufnr)

            -- cwd is only set if passed as telescope option
            local cwd = current_picker.cwd and tostring(current_picker.cwd)
                or vim.loop.cwd()
            local parent_dir = vim.fs.dirname(cwd)

            require("telescope.actions").close(prompt_bufnr)
            require("telescope.builtin").find_files {
                prompt_title = vim.fs.basename(parent_dir),
                cwd = parent_dir,}
        end,
      },
      n = {
        ["<c-d>"] = actions.delete_buffer,
        ["dd"] = actions.delete_buffer,
      },
    },
  },
})

-- Telescope commands
map('n', '<leader>tb', ':Telescope buffers<cr>', { desc = "[Telescope] Buffers"})
map('n', '<leader>tt', ':Telescope<cr>', {desc = "[Telescope]"})
map('n', '<leader>tf', ':Telescope find_files<cr>', { desc = "Telescope] Find files" })
map('n', '<leader>tg', ':Telescope live_grep<cr>', { desc = "[Telescope] Live grep" })
map('n', '<leader>th', ':Telescope help_tags<cr>', { desc = "[Telescope] Navigate help" })


