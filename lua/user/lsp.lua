langs =
{
	'pyright',
	'rust_analyzer',
	'clangd',
	'gopls',
	'sumneko_lua',
	'html',
	'eslint',
	'tsserver',
}

for i, langs in ipairs(langs) do
	require('lspconfig')[langs].setup{}
end


-- CSS workaround for completions

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.cssls.setup {
	capabilities = capabilities,
}
