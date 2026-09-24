-- Add plugins
vim.pack.add({
  'https://github.com/vyfor/cord.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-lua/plenary.nvim', -- For telescope
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/saghen/blink.lib',
  'https://github.com/saghen/blink.cmp',
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/akinsho/toggleterm.nvim',
  'https://github.com/rebelot/kanagawa.nvim',
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/brianhuster/live-preview.nvim',
})

-- Live preview
require('livepreview.config').set()

-- Cord
require("cord").setup({
  display = {
    theme = 'minecraft',
  },
})

-- Which-key
require("which-key").setup({
  delay = 1000,
})

-- Notifications
require("fidget").setup()

-- Mini
require("mini.ai").setup({})
require("mini.move").setup({})
require("mini.surround").setup({})
require("mini.cursorword").setup({})
require("mini.indentscope").setup({})
require("mini.pairs").setup({})
require("mini.trailspace").setup({})
require("mini.bufremove").setup({})
require("mini.icons").setup({})
require("mini.statusline").setup({})
require("mini.files").setup({})
--require("mini.animate").setup({})

-- Gitsigns
require("gitsigns").setup({})

-- Treesitter
require("nvim-treesitter").install{
    'c',
    'cpp',
    'c_sharp',
    'html',
    'css',
    'javascript',
    'java',
    'yaml',
    'xml',
    'lua',
    'rust',
    'javascript',
    'json',
    'bash',
    'php',
    'fish'
}

-- CMP
local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup()

-- Floating terminal
require("toggleterm").setup({

})

