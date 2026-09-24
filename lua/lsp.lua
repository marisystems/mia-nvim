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

	vim.keymap.set("n", "<leader>ld",
    ':Telescope lsp_definitions<cr>',
    {desc = "[LSP] Jump to Definition"})

	vim.keymap.set("n", "<leader>lD", vim.lsp.buf.definition, {desc = "[LSP] List all definitions"})

	vim.keymap.set("n", "<leader>lS", function()
		vim.cmd("vsplit")
		vim.lsp.buf.definition()
	end, {desc = "[LSP] Open definition in a split"})

	vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, {desc = "[LSP] Code actions"})
	vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, {desc = "[LSP] Rename all definitions under cursor"})

	vim.keymap.set("n", "<leader>lf", function()
		vim.diagnostic.open_float({ scope = "cursor" })
	end, {desc = "[LSP] Open diagnostic float under cursor"})

	vim.keymap.set("n", "<leader>lF", function()
		vim.diagnostic.open_float({ scope = "line" })
	end, {desc = "[LSP] Open diagnostic float under line"})

	vim.keymap.set("n", "<leader>lx", function()
		vim.diagnostic.jump({ count = 1 })
	end, {desc = "[LSP] Jump to next diagnostic"})

	vim.keymap.set("n", "<leader>lz", function()
		vim.diagnostic.jump({ count = -1 })
	end, {desc = "[LSP] Jump to earlier diagnostic"})

	vim.keymap.set("n", "K", vim.lsp.buf.hover, {desc = "Open Hover LSP"})
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.hover, {desc = "Open Hover LSP"})

	vim.keymap.set("n", "<leader>fr", function()
		require("fzf-lua").lsp_references()
	end, {desc = "[FZF] References"})
	vim.keymap.set("n", "<leader>ft", function()
		require("fzf-lua").lsp_typedefs()
	end, {desc = "[FZF] Type definitions"})
	vim.keymap.set("n", "<leader>fs", function()
		require("fzf-lua").lsp_document_symbols()
	end, {desc = "[FZF] Type Document Symbols"})
	vim.keymap.set("n", "<leader>fw", function()
		require("fzf-lua").lsp_workspace_symbols()
	end, {desc = "[FZF] Workspace Symbols"})
	vim.keymap.set("n", "<leader>fi", function()
		require("fzf-lua").lsp_implementations()
	end, {desc = "[FZF] Jump to implementation"})

	if client:supports_method("textDocument/codeAction", bufnr) then
		vim.keymap.set("n", "<leader>oi", function()
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

