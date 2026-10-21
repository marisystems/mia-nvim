vim.pack.add {
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/mason-org/mason.nvim' },
	{ src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
	{ src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
}

require('mason').setup()
require('mason-lspconfig').setup()
require('mason-tool-installer').setup({
	ensure_installed = {
		"lua_ls",
		"stylua",
    "pyright",
    "clangd",
    "rust-analyzer",
    "emmet-language-server",
    "typescript-language-server"
	}
})

-- ===============
-- LSP Keybindings
-- ===============
local function lsp_on_attach(ev)
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	if not client then
		return
	end

	local bufnr = ev.buf
	local opts = { noremap = true, silent = true, buffer = bufnr }
    local map = vim.keymap.set

	map("n", "<leader>ld",
    ':Telescope lsp_definitions<cr>',
    {desc = "[LSP] Jump to Definition"})

	map("n", "<leader>lD", vim.lsp.buf.definition, {desc = "[LSP] List all definitions"})

    map("n", "<leader>ls", function()
        local w = vim.api.nvim_win_get_width(0)
        local h = vim.api.nvim_win_get_height(0)
        local width
        local height

        if w < 75 then
            width = math.floor(w * 0.9) -- Percentage of the screen
            height = math.floor(h * 0.9)
        else
            width = math.floor(w * 0.6) -- Percentage of the screen
            height = math.floor(h * 0.6)
        end

        local win = vim.api.nvim_open_win(0, true,
           {relative='editor',
           width= width,
           height=height,
           col = (w / 2) - (width/2),
           row = (h / 2) - (height/2),
           bufpos={500,10},
           border = {"┏", "━", "┓", "┃", "┛", "━", "┗", "┃"},
           })
        vim.api.nvim_win_call(win, function()
            vim.lsp.buf.definition()
        end)
    end, {desc = "[LSP] open definition in a float"})

	map("n", "<leader>la", vim.lsp.buf.code_action, {desc = "[LSP] Code actions"})
	map("n", "<leader>ln", vim.lsp.buf.rename, {desc = "[LSP] Rename all definitions under cursor"})

	map("n", "<leader>lf", function()
		vim.diagnostic.open_float({ scope = "cursor" })
	end, {desc = "[LSP] Open diagnostic float under cursor"})

	map("n", "<leader>lF", function()
		vim.diagnostic.open_float({ scope = "line" })
	end, {desc = "[LSP] Open diagnostic float under line"})

	map("n", "<leader>lx", function()
		vim.diagnostic.jump({ count = 1 })
	end, {desc = "[LSP] Jump to next diagnostic"})

	map("n", "<leader>lz", function()
		vim.diagnostic.jump({ count = -1 })
	end, {desc = "[LSP] Jump to earlier diagnostic"})

	map("n", "K", vim.lsp.buf.hover, {desc = "Open Hover LSP"})
    map("i", "<C-k>", vim.lsp.buf.hover, {desc = "Open Hover LSP"})

	map("n", "<leader>fr", function()
		require("fzf-lua").lsp_references()
	end, {desc = "[FZF] References"})
	map("n", "<leader>ft", function()
		require("fzf-lua").lsp_typedefs()
	end, {desc = "[FZF] Type definitions"})
	map("n", "<leader>fs", function()
		require("fzf-lua").lsp_document_symbols()
	end, {desc = "[FZF] Type Document Symbols"})
	map("n", "<leader>fw", function()
		require("fzf-lua").lsp_workspace_symbols()
	end, {desc = "[FZF] Workspace Symbols"})
	map("n", "<leader>fi", function()
		require("fzf-lua").lsp_implementations()
	end, {desc = "[FZF] Jump to implementation"})

	if client:supports_method("textDocument/codeAction", bufnr) then
		map("n", "<leader>oi", function()
			vim.lsp.buf.code_action({
				context = { only = { "source.organizeImports" }, diagnostics = {} },
				apply = true,
				bufnr = bufnr,
			})
			vim.defer_fn(function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end, 50)
		end, opts)
	end
end

vim.api.nvim_create_autocmd("LspAttach", { group = augroup, callback = lsp_on_attach })

-- Optional config below

-- Vim config,makes vim API auto complete
vim.lsp.config("lua_ls", {
  root_markers = {'.lua'},
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
        }
      }
    }
  }
})

-- Make clangd adhere to C23 standard
vim.lsp.config("clangd", {
    init_options = {
        fallbackFlags = { '--std=c23'}
    },
})

