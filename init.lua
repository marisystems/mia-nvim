-- Add plugins
vim.pack.add({
  "https://www.github.com/nvim-tree/nvim-tree.lua",
  'https://github.com/vyfor/cord.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/lewis6991/gitsigns.nvim'
})

local function packadd(name)
  vim.cmd("packadd " .. name)
end

-- Some plugins don't get loaded until packadd is called
-- So might as well just use on them all
--packadd("nvim-tree")

-- Nvim-tree
require("nvim-tree").setup({
  filters = {
    dotfiles = false
  },
})
vim.keymap.set("n", "<leader>e", function()
  require("nvim-tree.api").tree.toggle()
end, { desc = "Toggle NvimTree"})

-- Cord
require("cord").setup({
  display = {
    theme = 'minecraft',
  },
})

-- Telescope
require("telescope").setup()

-- Mini
require("mini.ai").setup({})
require("mini.move").setup({})
require("mini.surround").setup({})
require("mini.cursorword").setup({})
require("mini.indentscope").setup({})
require("mini.pairs").setup({})
require("mini.trailspace").setup({})
require("mini.bufremove").setup({})
require("mini.notify").setup({})
require("mini.icons").setup({})
--require("mini.animate").setup({})
require("mini.statusline").setup({})

-- Gitsigns
require("gitsigns").setup({})

-- =======
-- Require
-- =======
require("options")
require("keymaps")
require("auto")
