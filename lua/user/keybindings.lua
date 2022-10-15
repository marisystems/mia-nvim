-- Where i set my custom keybindings

local map = vim.api.nvim_set_keymap

-- Leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ' '

options = { noremap = true }

-- Highlight dismiss
map('n', '<leader>c', ':noh<cr>', options)

-- Save
map('n', '<C-s>s', ':w<cr>', options)
map('n', '<C-s>q', ':wq<cr>', options)

-- Repeat last command
map('n', '<C-p>', ':@:<cr>', options)

-- Telescope commands
map('n', 'ff', ':Telescope find_files<cr>', {})
map('n', 'fg', ':Telescope live_grep<cr>', {})
map('n', 'fb', ':Telescope buffers<cr>', {})
map('n', 'fh', ':Telescope help_tags<cr>', {})

-- Pane movement
map('n', '<C-Up>', ':wincmd k<cr>', {})
map('n', '<C-Down>', ':wincmd j<cr>', {})
map('n', '<C-Left>', ':wincmd h<cr>', {})
map('n', '<C-Right>', ':wincmd l<cr>', {})

map('n', '<S-Up>', ':wincmd K<cr>', {})
map('n', '<S-Down>', ':wincmd J<cr>', {})
map('n', '<S-Left>', ':wincmd H<cr>', {})
map('n', '<S-Right>', ':wincmd L<cr>', {})
