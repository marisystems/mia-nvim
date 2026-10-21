vim.pack.add({
  'https://github.com/saghen/blink.lib',
  'https://github.com/saghen/blink.cmp',
})

local cmp = require('blink.cmp')
cmp.build():pwait()

cmp.setup({
    completion = {
        menu = { border = 'single' },
        documentation = { window = { border = 'single' } },
    },

    signature = {
        enabled = true,
        window = {
            border = 'single',
        },
    },
})
