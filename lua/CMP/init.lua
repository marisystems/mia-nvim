local cmp = require'cmp'


cmp.setup({

	snippet = {
		-- Specifying the snippet engine
		expand = function(args)
			require('luasnip').lsp_expand(args, body)
		end,
	},

	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	
	-- Add your keybindings here
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),	
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true })
	}),

	-- Set the sources for cmp
	   sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
    })
	
	-- Configuration for specific filetypes
--	cmp.setup.filetype('gitcommit', {
--
--		sources = cmp.config.sources({
--			{ name = 'cmp_git' },
--		}, {
--			{ name= 'buffer' },
--		})

--	})

	-- Use cmdline & path source for ':'
	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		
		sources = cmp.config.sources({
			{ name = 'path' }
		}, {
			{ name = 'cmdline' }
		})

	})

  })
